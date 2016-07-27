# from my user page i can see a list of existing skills that I’ve entered
# I add skills
# when I click submit, my skill is added to the list

RSpec.feature "user can see and add skills from dashboard" do
  scenario "user sees skills" do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    user_skill = user.skills.create(nickname: "skill1", description: "description for skill 1")
    other_skill = Skill.create(nickname: "notmyskill", description: "notmyskill description", user_id: user.id + 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path
    within("#skills") do
      expect(page).to have_content(user_skill.nickname)
      expect(page).to have_content(user_skill.description)
      expect(page).to_not have_content(other_skill.nickname)
      expect(page).to_not have_content(other_skill.description)
    end

  end

end
