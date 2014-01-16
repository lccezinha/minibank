require 'spec_helper'

describe ExtractsController do

  before(:each) do
    controller.stub(:authenticate_user!).and_return(true)
  end

  it 'GET: /' do
    get :index
    expect(response).to be_success
  end

end