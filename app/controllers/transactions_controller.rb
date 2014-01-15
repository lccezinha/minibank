class TransactionsController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @transaction = @account.transactions.build
    respond_with @transaction
  end

  def create
    @transaction = @account.transactions.build transaction_params

    transaction_service = TransactionService.new @transaction.operation,
      @account, current_user, @transaction.value

    @transaction, flash = transaction_service.execute
    respond_with @transaction, location: root_path
  end

  private

  def load_account
    @account = current_user.account
  end

  def transaction_params
    params.require(:transaction).permit(:value, :operation)
  end
end