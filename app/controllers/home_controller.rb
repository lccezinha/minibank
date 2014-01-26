class HomeController < ApplicationController
  layout 'home'

  def index
    @movimentations = current_user.account.movimentations.where(operation: ['entry', 'deposit'])
    @transfers = Movimentation.my_transfers(current_user.account)
    respond_with @movimentations, @transfers
  end
end
