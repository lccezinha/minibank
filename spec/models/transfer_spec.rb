require 'spec_helper'

describe Transfer do
  context 'transfers' do
    let(:user) { create :user }
    let(:user_two) { create :user }

    let(:account) { create :account, user_id: user.id }
    let(:account_two) { create :account, user_id: user_two.id }

    it do
      transfer = double('Transfer')
      transfer.stub(:operation) { 'transfer' }
      expect(transfer.operation).to eql('transfer')
    end

    context 'validations' do
      context 'presence of' do
        it { should validate_presence_of :account_destiny_id }
        it { should validate_presence_of :account_id }
        it { should validate_presence_of :quantity }
      end
      context 'numericality' do
        [:quantity].each do |value|
          it { should validate_numericality_of(value) }
          it { should_not allow_value(-1).for value }
        end
      end
    end

    it 'account_id and account_destiny_id can not be equal' do
      account = create :account
      account_two = create :account
      transfer = Transfer.new account_id: account.id,
        account_destiny_id: account.id, quantity: 50
      # p transfer
      expect(transfer).not_to be_valid
    end

    it 'account_destiny_id need exist' do
      pending
    end

    it 'transfer quantity must be greater_than 0' do
      transaction = build :transaction, operation: 'transfer', quantity: 0,
        account_destiny_id: account_two.id , account_id: account.id
      expect(transaction).not_to be_valid
    end

    context 'transfer from account A to B' do
      it 'should discount from A' do
        pending
      end

      it 'should add to B' do
        pending
      end
    end

    context 'applying taxes' do
      pending
    end
  end
end