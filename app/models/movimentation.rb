class Movimentation < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :quantity
  validates_numericality_of :quantity, greater_than: 0

  validate :check_quantity, :unless => Proc.new { |transaction|
    transaction.quantity.nil? || transaction.quantity.blank?
  }

  scope :by_period, ->(start_date, end_date, account) {
    where("date(created_at) BETWEEN ? AND ?", start_date, end_date).by_user(account)
  }

  scope :my_transfers, -> (account) {
    where(operation: 'transfer').by_user(account)
  }

  scope :by_user, -> (account) {
    where("account_id = :account OR account_destiny_id = :account", account: account.id)
  }

  def check_quantity
    if entry?
      errors.add(:quantity, 'Saldo insuficiente.') unless account.minus(quantity)
    elsif deposit?
      errors.add(:quantity, 'Valor inválido para depósito') unless account.plus(quantity)
    end
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