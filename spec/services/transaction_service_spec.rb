require 'spec_helper'

describe TransactionService do

  it 'when deposit' do
    user = create :user
    account = create :account, user_id: user.id
    transaction = create :transaction, account_id: account.id, operation: 'deposit'

    transaction_service = TransactionService.new transaction.operation,
      account, user, transaction.quantity

    transaction_service.stub_chain(:execute, :deposit)
  end

  it 'when entry' do
    user = create :user
    account = create :account, user_id: user.id
    transaction = create :transaction, account_id: account.id, operation: 'entry'

    transaction_service = TransactionService.new transaction.operation,
      account, user, transaction.quantity

    transaction_service.stub_chain(:execute, :entry)
  end

end

