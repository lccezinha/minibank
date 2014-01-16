require 'spec_helper'

describe TransactionService do

  it 'when deposit' do
    user = create :user
    account = create :account, user_id: user.id
    transaction = create :transaction, account_id: account.id, operation: 'deposit'

    transaction_service = TransactionService.new transaction.operation,
      account, user, transaction.value

    expect {
      transaction_service.execute
    }.to change(account, :total).by(transaction.value)
  end
  # it 'when booty' do
  #   user = create :user
  #   account = create :account, user_id: user.id
  #   transaction = create :transaction, account_id: account.id, operation: 'deposit'
  #   transaction_service = TransactionService.new transaction
  #   transaction_service.stub_chain(:execute, :booty)
  # end

end

