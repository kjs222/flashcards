class Api::V1::UsersController < ApplicationController

  def show
    credentials = User.get_credentials_for_cli(user_params[:uid], user_params[:password])
    render json: credentials
  end

  private

  def user_params
    params.permit(:uid, :password)
  end


end
