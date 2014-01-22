class Transfer
  include ActiveModel::Model
  attr_accessor :account_id, :account_destiny_id, :quantity

  validates_presence_of :account_destiny_id
  validates_presence_of :account_id
  validates_presence_of :quantity
  validates_numericality_of :quantity, greater_than: 0

  validate :check_account_destiny_id

  def check_account_destiny_id
    errors.add(:account_destiny_id, 'Conta destino não pode ser a conta de origem') if account_id.eql?(account_destiny_id)
  end

  def operation
    'transfer'
  end
end