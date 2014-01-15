class UsersController < ApplicationController
  layout 'home'
  before_action :load_user

  def edit
    respond_with @user
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    flash[:notice] = 'Dados de conta atualizados' if
      @user.update_attributes(params[:user])
    respond_with @user, location: root_path
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :email, :cpf, :password,
      :password_confirmation)
  end

end