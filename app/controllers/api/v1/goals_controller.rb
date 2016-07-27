class Api::V1::GoalsController < ApplicationController

  def create
    goal = Goal.create(goal_params)
    render json: goal
  end

  private

  def goal_params
    params.require(:goal).permit(:skill_id, :num_sessions, :session_length)
  end


end
