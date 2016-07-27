require 'rails_helper'

RSpec.feature "user sees his current and next week goals" do
  scenario "user current and future goals are shown" do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    skill_1 = user.skills.create(nickname: "skill1", description: "description for skill 1")
    skill_2 = user.skills.create(nickname: "skill2", description: "description for skill 2")

    current_goal = skill_1.goals.create(week_number: Date.today.cweek, num_sessions: 5, session_length: 15)

    next_goal = skill_2.goals.create(week_number: Date.today.cweek + 1, skill_id: skill_2.id, num_sessions: 3, session_length: 60)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path

    within("#current-goals") do
      expect(page).to have_content(current_goal.skill.nickname)
      expect(page).to_not have_content(next_goal.skill.nickname)
      expect(page).to have_content(current_goal.num_sessions)
      expect(page).to_not have_content(next_goal.num_sessions)
    end

    within("#next-goals") do
      expect(page).to_not have_content(current_goal.skill.nickname)
      expect(page).to have_content(next_goal.skill.nickname)
      expect(page).to_not have_content(current_goal.num_sessions)
      expect(page).to have_content(next_goal.num_sessions)
    end

  end

end
