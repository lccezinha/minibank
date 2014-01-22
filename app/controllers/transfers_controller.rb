class TransfersController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @movimentation = @account.movimentations.build
    respond_with @movimentation
  end

  def create
  end

  private

  def load_account
    @account = current_user.account
  end

  def movimentation_params
    params.require(:movimentation).permit(:quantity, :operation)
  end
end