require 'spec_helper'

describe Transaction do

  context 'associations' do
    it { should belong_to :account }
  end

  context 'validations' do
    context 'presence' do
      [:quantity].each do |value|
        it { should validate_presence_of value }
      end
    end

    context 'numericality' do
      [:quantity].each do |value|
        it { should validate_numericality_of(value) }
        it { should_not allow_value(-1).for value }
      end
    end
  end

  context 'operations' do
    it 'entry?' do
      account = create :account
      transaction = create :transaction, operation: 'entry',
        account_id: account.id
      expect(transaction.entry?).to be_true
    end
    it 'deposit?' do
      account = create :account
      transaction = create :transaction, operation: 'deposit',
        account_id: account.id
      expect(transaction.deposit?).to be_true
    end
  end
end