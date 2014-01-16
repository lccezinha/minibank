require 'spec_helper'

describe TransactionsController do

  before(:each) do
    controller.stub(:authenticate_user!).and_return(true)
  end

  it 'GET: /new' do
    get :new
    expect(response).to be_success
  end

end