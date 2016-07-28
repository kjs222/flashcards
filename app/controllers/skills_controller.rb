class SkillsController < ApplicationController

  def index
    @skills = current_user.skills
  end


end
