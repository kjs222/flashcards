class Api::V1::UserFollowersController < ApplicationController

  def create
    @user_follower = UserFollower.create(follower_params)
    @follower = @user_follower.follower
    render json: [@user_follower, @follower]
  end

  def destroy
    @user_follower = UserFollower.find(params[:id])
    @user_follower.destroy
    render json: {message: "deleted"} #for testing
  end

  private

  def follower_params
    params.require(:user_follower).permit(:user_id, :follower_id)
  end



end
