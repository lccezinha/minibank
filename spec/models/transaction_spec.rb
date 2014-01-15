require 'spec_helper'

describe Transaction do

  context 'associations' do
    it { should belong_to :account }
  end

  context 'validations' do
    context 'presence' do
      [:value].each do |value|
        it { should validate_presence_of value }
      end
    end

    context 'numericality' do
      [:value].each do |value|
        it { should validate_numericality_of(value).only_integer }
        it { should_not allow_value(-1).for value }
      end
    end
  end

  context 'operations' do

    context 'when plus' do
      pending
      # user = create :user
      # account = create :account, user_id: user.id
      # transaction = create :transaction, account_id: account.id, operation: 'deposit'

    end
    context 'when minus' do
      pending
    end

  end

end