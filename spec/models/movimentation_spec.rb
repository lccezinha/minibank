require 'spec_helper'

describe Movimentation do

  context 'associations' do
    it { should belong_to :account }
  end

  it 'respond_to' do
    expect(Movimentation).to respond_to(:by_period)
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
    movimentation = build :movimentation, operation: 'entry',
      account_id: account.id
    expect { movimentation.save }.to change(Movimentation, :count).by(1)
  end

  context 'operations' do
    it 'entry?' do
      account = create :account
      movimentation = create :movimentation, operation: 'entry',
        account_id: account.id
      expect(movimentation.entry?).to be_true
    end
    it 'deposit?' do
      account = create :account
      movimentation = create :movimentation, operation: 'deposit',
        account_id: account.id
      expect(movimentation.deposit?).to be_true
    end
  end

  it 'when movimentation is a deposit or a entry, account_destiny_id need be nil' do
    movimentation = build :movimentation, operation: 'entry', quantity: 100
    expect(movimentation.account_destiny_id).to be_nil
  end
end

# li = 'De segunda a sexta das 9 às 18 horas a taxa é 5 reais por transferência'
# li = 'Fora desse horário a taxa é 7 reais'
# li = 'Acima de 1000 reais há um adicional de 10 reais na taxa'