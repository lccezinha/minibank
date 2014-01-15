require 'spec_helper'

describe Account do

  context 'associations' do
    it { should belong_to :user }
    it { should have_many :transactions }
  end

  it 'should start with 100,00' do
    user = create :user
    account = create :account, user_id: user.id
    expect(account.total).to eql(100)
  end

  it 'account belongs to user' do
    user = create :user
    account = create :account, user_id: user.id
    expect(account.user_id).to eql(user.id)
  end

  context 'numericality' do
    [:total].each do |value|
      it { should validate_numericality_of(value) }
      it { should_not allow_value(-1).for value }
    end
  end

  it 'should generate a random value to number' do
    pending
  end

end