class MovimentationsController < ApplicationController
  layout 'home'
  before_action :load_account

  def new
    @movimentation = @account.movimentations.build
    respond_with @movimentation
  end

  private

  def load_account
    @account = current_user.account
  end
end