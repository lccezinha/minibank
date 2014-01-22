class TransfersController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @transfer = Transfer.new
    respond_with @transfer
  end

  def create
    @transfer = Transfer.new params[:transfer]
    if @transfer.valid?
      transfer_service = TransferService.new @transfer
      flash[:messge] = 'Transferência efetuada.' if transfer_service.run
    end
    respond_with @transfer, location: root_path
  end

  private

  def load_account
    @account = current_user.account
  end

  def movimentation_params
    params.require(:movimentation).permit(:quantity, :operation)
  end
end