require 'rails_helper'

RSpec.feature "user can log a session from dashboard" do
  xscenario "user logs a session for a current goal", js: true do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    current_skill = user.skills.create(nickname: "skill1", description: "description for skill 1")
    not_current_skill = Skill.create(nickname: "notmyskill", description: "notmyskill description", user_id: user.id + 1)
    current_goal = current_skill.goals.create(week_number: Date.today.cweek, num_sessions: 5, session_length: 15)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path
    #FORMS NOT WORKING DUE TO JQUERY
    within("#log-session") do
      expect(page).to_not have_select("skill_nickname[skill_id]", options: [current_skill.nickname, not_current_skill.nickname])
      expect(page).to have_select("skill_nickname[skill_id]", options: [current_skill.nickname])
      fill_in("session-length-log", with: 30)
      click_on "Log Session"
    end

    within("#current-sessions") do
      expect(page).to have_content(current_skill.nickname)
      expect(page).to have_content("30 minutes")
    end

  end
end
