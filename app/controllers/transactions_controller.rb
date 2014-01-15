class TransactionsController < ApplicationController
  layout 'home'
  def new
    account = current_user.account
    @transaction = account.transactions.build
    respond_with @transaction
  end

  def create
  end
end