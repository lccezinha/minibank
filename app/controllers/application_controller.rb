class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def load_account
    @account = current_user.account
  end

  def configure_permitted_parameters
    [:sign_up, :sign_in, :account_update].each do |method|
      devise_parameter_sanitizer.for(method) << [:name, :cpf]
    end
  end
end
