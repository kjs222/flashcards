require 'rails_helper'

RSpec.feature "user sees log session form when appropriate" do

  scenario "user with current goals sees form" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path

    expect(page).to have_content("Log a Practice Session")

  end

  scenario "user without current goals does not see form" do

    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:next_week_goal, skill: skill)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path

    expect(page).to_not have_content("Log a Practice Session")

  end


end
