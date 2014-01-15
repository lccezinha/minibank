require 'spec_helper'

describe Account do

  context 'associations' do
    it { should belong_to :user }
  end

  it 'should start with 100,00' do
    user = create :user
    account = create :account, user_id: user.id
    expect(account.total).to eql(100)
  end

end