require 'spec_helper'

describe UsersController do

  before(:each) do
    controller.stub(:authenticate_user!).and_return(true)
  end

  let(:user_params) { { name: 'Dave Mustaine', cpf: '12332121321',
     email: 'miojao@megadeth.com' }  }

  it '/ :PUT should update user without change password' do
    user = create :user, user_params
    new_name = 'James Hetfield'
    put :update, id: user.id, user: user_params.merge(name: new_name)
    expect(user.reload.name).to eql(new_name)
  end

end