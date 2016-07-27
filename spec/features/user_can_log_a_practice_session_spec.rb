# from my user page, i can click on log a session
# i have an option to select skills (from my current goals only?  if not, figure this out later)
# i select a skill
# I enter a time
# i hit submit and session gets logged

RSpec.feature "user can log a session from dashboard" do
  scenario "user logs a session for a current goal" do

    visit dashboard_index_path

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    current_skill = user.skills.create(nickname: "skill1", description: "description for skill 1")
    not_current_skill = Skill.create(nickname: "notmyskill", description: "notmyskill description", user_id: user.id + 1)
    current_goal = current_skill.goals.create(week_number: Date.today.cweek, num_sessions: 5, session_length: 15)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    within("#log-session") do
      expect(page).to_not have_select("skill_nickname[skill_id]", options: [current_skill.nickname, not_current_skill.nickname])
      expect(page).to_not have_select("skill_nickname[skill_id]", options: [current_skill.nickname])
      fill_in("session[duration]", with: 30)
      click_on "Log Session"
    end

    within("#current-sessions") do
      expect(page).to have_content(current_skill.nickname)
      expect(page).to have_content("30 minutes")
    end

  end
end
