class Api::V1::UsersController < ApplicationController

  def show
    token = User.get_token_for_cli(user_params[:uid], user_params[:password])
    render json: token
  end

  private

  def user_params
    params.permit(:uid, :password)
  end


end
