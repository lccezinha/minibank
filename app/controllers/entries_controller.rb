class EntriesController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @transaction = @account.transactions.build
    respond_with @transaction
  end

  def create
    @transaction = @account.transactions.build transaction_params

    transaction_service = TransactionService.new @transaction.operation,
      @account, current_user, @transaction.quantity

    flash[:notice] = transaction_service.execute
    @transaction.save if flash[:notice].present?
    respond_with @transaction, location: root_path
  end

  private

  def load_account
    @account = current_user.account
  end

  def transaction_params
    params.require(:transaction).permit(:quantity, :operation)
  end
end