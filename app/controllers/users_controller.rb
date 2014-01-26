class UsersController < ApplicationController
  layout 'home'
  before_action :load_user

  def edit
    respond_with @user
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    flash[:notice] = 'Dados de conta atualizados' if
      @user.update_attributes(user_params)
    respond_with @user, location: root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :cpf, :password,
      :password_confirmation)
  end
end