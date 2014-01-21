class Transaction < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :quantity
  validates_numericality_of :quantity, greater_than: 0

  validate :check_quantity, :unless => Proc.new { |transaction|
    transaction.quantity.nil? || transaction.quantity.blank?
  }

  validates_presence_of :account_destiny_id, :if => Proc.new { |transaction|
    transaction.transfer?
  }

  # validate :check_valid_account_destiny_id, :if => Proc.new { |transaction|
  #   transaction.transfer?
  # }

  scope :by_period, ->(start_date, end_date, account) {
    where("date(created_at) BETWEEN ? AND ?", start_date, end_date).
    where(account_id: account.id)
  }

  def check_quantity
    if entry?
      errors.add(:quantity, 'Saldo insuficiente.') unless account.minus(quantity)
    elsif deposit?
      errors.add(:quantity, 'Valor inválido para depósito') unless account.plus(quantity)
    end
  end

  def check_valid_account_destiny_id
    Account.find account_destiny_id
  end

  def transfer?
    operation.eql?('transfer')
  end

  def entry?
    operation.eql?('entry')
  end

  def deposit?
    operation.eql?('deposit')
  end

end