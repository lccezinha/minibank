require 'spec_helper'

describe Account do
  context 'associations' do
    it { should belong_to :user }
    it { should have_many :movimentations }
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

  context 'respond_to' do
    it { should respond_to(:minus) }
    it { should respond_to(:plus) }
  end

  context 'operations' do
    it 'when deposit is done' do
      user = create :user
      account = create :account, user_id: user.id
      deposit = 10
      expect { account.plus(deposit) }.to change(account, :total).by(deposit)
    end

    it 'when try to deposit <= 0' do
      user = create :user
      account = create :account, user_id: user.id
      deposit = 0
      expect(account.plus(deposit)).to be_false
    end

    it 'when try to entry more than total' do
      user = create :user
      account = create :account, user_id: user.id
      entry = 110
      expect(account.minus(entry)).to be_false
    end

    it 'when entry is done' do
      user = create :user
      account = create :account, user_id: user.id
      entry = 10
      expect { account.minus(entry) }.to change(account, :total).by(-entry)
    end
  end

end