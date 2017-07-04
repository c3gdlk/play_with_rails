class Api::V1::BaseController < ApplicationController
  respond_to :json

  private

  def authenticate_user!
    if user_signed_in?
      sign_in current_user, store: false
    else
      render json: {sucess: false, message: 'Not Authorized'}, status: 401
    end
  end

  def current_user
    @current_user ||= User.where(auth_token: params[:auth_token]).first
  end

end
