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

  it 'should generate a random value to number' do
    # user = create :user
    # account = build :account, user_id: user.id
    # expect(account.number).not_to be_blank
    # expect { account.save }.to
  end

end