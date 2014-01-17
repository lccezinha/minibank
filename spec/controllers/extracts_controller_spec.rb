require 'spec_helper'

describe ExtractsController do
  before(:each) do
    controller.stub(:authenticate_user!).and_return(true)
  end
end