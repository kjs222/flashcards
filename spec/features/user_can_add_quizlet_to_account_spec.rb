require 'rails_helper'

RSpec.feature "user can add quizlet to their account" do

  scenario "adds quizlet" do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    expect(user.quiz_id).to eq(nil)
    expect(user.quiz_token).to eq(nil)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )
    visit dashboard_index_path
    within("nav") do
      click_link "Welcome, Kerry Sheldon"
    end
    expect(current_path).to eq(account_path)
    expect(page).to have_content("Kerry Sheldon")
    expect(page).to have_content("kjs222")
    within (".quizlet") do
      expect(page).to have_content("Not Enabled")
      stub_quizlet_omniauth
      click_button "Enable Quizlet"
    end
    expect(current_path).to eq(account_path)
    within (".quizlet") do
      expect(page).to_not have_content("Not Enabled")
      expect(page).to_not have_button("Enable Quizlet")
      expect(page).to have_content("Activated")
    end
    expect(user.quiz_id).to_not eq(nil)
    expect(user.quiz_token).to_not eq(nil)
  end

end
