class HomeController < ApplicationController
  layout 'home'

  def index
    @movimentations = current_user.account.movimentations
    respond_with @movimentations
  end
end
