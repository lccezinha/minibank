class EntriesController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @movimentation = @account.movimentations.build
    respond_with @movimentation
  end

  def create
    @movimentation = @account.movimentations.build movimentation_params
    flash[:notice] = 'Saque realizado com sucesso.' if @movimentation.save
    respond_with @movimentation, location: root_path
  end

  private

  def load_account
    @account = current_user.account
  end

  def movimentation_params
    params.require(:movimentation).permit(:quantity, :operation)
  end
end