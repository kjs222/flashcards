require 'rails_helper'

RSpec.feature "user adds goals via dash" do

  xscenario "user can add a current goal", js: true do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    skill_1 = user.skills.create(nickname: "skill1", description: "description for skill 1")
    skill_2 = user.skills.create(nickname: "skill2", description: "description for skill 2")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path

    within(".new-current-goal-form") do
      #NOT WORKING WITHOUT SELENIUM BC DROPDOWNS POPULATED BY JQUERY
      #NOT WORKING IN SELENIUM BC OTHER DROP DOWN NOT POPULATING
      #TRIED SLEEP 10, TRIED WAIT FOR AJAX, TRIED EXECUTING SCIPT WIHTIHN TEST file
      #ALSO WIERD BECAUSE IT WONT WORK WITH JUST DOING FIELDS THAT ARE HERE
      expect(page).to have_select("skill_nickname[skill_id]", options: [skill_1.nickname, skill_2.nickname])
      select  skill_1.nickname, from: "skill_nickname[skill_id]"
      select  2, from: "num-sessions-current"
      select  30, from: "session-length-current"
      click_on "Add Goal"
    end

    within("#current-goals") do
      expect(page).to have_content(skill_1.nickname)
      expect(page).to have_content(2)
      expect(page).to have_content(30)
    end


    expect(user.goals.count).to eq(1)

  end

  xscenario "user can add a next week goal", js: true do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    skill_1 = user.skills.create(nickname: "skill1", description: "description for skill 1")
    skill_2 = user.skills.create(nickname: "skill2", description: "description for skill 2")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path

    within(".new-next-goal-form") do
      #NOT WORKING WITHOUT SELENIUM BC DROPDOWNS POPULATED BY JQUERY
      #NOT WORKING IN SELENIUM BC OTHER DROP DOWN NOT POPULATING
      #TRIED SLEEP 10, TRIED WAIT FOR AJAX, TRIED EXECUTING SCIPT WIHTIHN TEST file
      #ALSO WIERD BECAUSE IT WONT WORK WITH JUST DOING FIELDS THAT ARE HERE
      expect(page).to have_select("skill_nickname[skill_id]", options: [skill_1.nickname, skill_2.nickname])
      select  skill_1.nickname, from: "skill_nickname[skill_id]"
      select  2, from: "num-sessions-current"
      select  30, from: "session-length-current"
      click_on "Add Goal"
    end

    within("#current-goals") do
      expect(page).to have_content(skill_1.nickname)
      expect(page).to have_content(2)
      expect(page).to have_content(30)
    end


    expect(user.goals.count).to eq(1)

  end

end
