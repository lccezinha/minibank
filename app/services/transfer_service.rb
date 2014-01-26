class TransferService
  attr_reader :transfer

  TAXES = {
    business_hour: 5,
    off_business_hour: 7,
    weekend: 7,
    big_quantity: 100
  }

  def initialize(transfer)
    @transfer = transfer
    @from = Account.find(@transfer.account_id)
  end

  def run
    ActiveRecord::Base.transaction do
      begin
        to   = Account.find(@transfer.account_destiny_id)
        if @from.minus(@transfer.quantity)
          to.plus(@transfer.quantity)
          movimentation = Movimentation.create!(
            account_id: @from.id, account_destiny_id: to.id,
            quantity: @transfer.quantity, operation: @transfer.operation
          )
          apply_taxes movimentation
        end
      rescue => ex
        Rails.logger.info "Exception: #{ex.class}. Msg: #{ex.message}. Trace: #{ex.backtrace}"
        raise ActiveRecord::Rollback
      end
    end
  end

  def apply_taxes(movimentation)
    tax = if movimentation.created_at.to_date.sunday? || movimentation.created_at.to_date.saturday?
      TAXES[:weekend]
    else
      if movimentation.created_at.to_time.beginning_of_hour.hour >= 9 and movimentation.created_at.to_time.end_of_hour.hour <= 18
        TAXES[:business_hour]
      else
        TAXES[:off_business_hour]
      end
    end

    final_tax = (movimentation.quantity >= 1000) ? (tax + 10) : tax
    @from.minus final_tax
  end

end