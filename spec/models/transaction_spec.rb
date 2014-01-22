require 'spec_helper'

describe Transaction do

  context 'associations' do
    it { should belong_to :account }
  end

  it 'respond_to' do
    expect(Transaction).to respond_to(:by_period)
    should respond_to :check_quantity
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

  it do
    account = create :account
    transaction = build :transaction, operation: 'entry',
      account_id: account.id
    expect { transaction.save }.to change(Transaction, :count).by(1)
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

  it 'when transaction is a deposit or a entry, account_destiny_id need be nil' do
    transaction = build :transaction, operation: 'entry', quantity: 100
    expect(transaction.account_destiny_id).to be_nil
  end
end

# li = 'De segunda a sexta das 9 às 18 horas a taxa é 5 reais por transferência'
# li = 'Fora desse horário a taxa é 7 reais'
# li = 'Acima de 1000 reais há um adicional de 10 reais na taxa'