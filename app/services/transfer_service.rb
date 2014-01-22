class TransferService
  attr_reader :transfer

  def initialize(transfer)
    @transfer = transfer
  end

  def run
    ActiveRecord::Base.transaction do
      begin
        from = Account.find(@transfer.account_id)
        to   = Account.find(@transfer.account_destiny_id)
        from.minus(@transfer.quantity)
        to.plus(@transfer.quantity)
        Movimentation.create!(account_id: from.id, account_destiny_id: to.id, quantity: @transfer.quantity, operation: @transfer.operation)
      rescue => ex
        Rails.logger.info "Exception: #{ex.class}. Msg: #{ex.message}. Trace: #{ex.backtrace}"
        raise ActiveRecord::Rollback
      end
    end
  end
end