class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_user!
    unless user_signed_in?
      flash[:error] = 'No Access'
      redirect_to root_path
    end
  end
end
