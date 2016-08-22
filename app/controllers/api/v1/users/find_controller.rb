class Api::V1::Users::FindController < ApplicationController

  def show
    @user = User.find_by(nickname: params[:user_nickname])
    if @user
      # render json: @user
      redirect_to(user_path(@user.nickname))
    else
      # render json: {message: "User not found"}
      flash[:info] = "User not found"
      redirect_to(community_path)
    end
  end

end
