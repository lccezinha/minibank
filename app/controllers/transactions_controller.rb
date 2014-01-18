class TransactionsController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @transaction = @account.transactions.build
    respond_with @transaction
  end

  private

  def load_account
    @account = current_user.account
  end
end