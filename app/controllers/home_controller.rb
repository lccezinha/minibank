class HomeController < ApplicationController
  layout 'home'

  def index
    @transactions = current_user.account.transactions
    respond_with @transactions
  end
end
