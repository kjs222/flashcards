require 'rails_helper'

RSpec.feature "user can login with github" do

  scenario "user authenticates with github" do
    visit root_path
    stub_omniauth
    expect(page).to_not have_content("Kerry Sheldon")
    expect(page).to have_button("Login with Github")

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    click_button "Login with Github"
    expect(current_path).to eq(dashboard_index_path)
    within("nav") do
      expect(page).to have_content("Welcome, Kerry Sheldon")
      expect(page).to have_link("Logout")
    end
  end

end
