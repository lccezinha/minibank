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

  it '/ :PUT should update user with change password' do
    pending
    # user = create :user, user_params
    # new_password = '123456'
    # put :update, id: user.id, user: user_params.merge(password: new_password,
    #   password_confirmation: new_password, current_password: user.password)
    # expect(user.reload.password).to eql(new_password)
  end

end