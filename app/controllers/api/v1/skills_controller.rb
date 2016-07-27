class Api::V1::SkillsController < ApplicationController

  def create
    skill = Skill.create(skill_params)
    render json: skill
  end

  private

  def skill_params
    params.require(:skill).permit(:nickname, :description, :user_id)
  end


end
