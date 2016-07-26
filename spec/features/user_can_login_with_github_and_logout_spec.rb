require 'rails_helper'

RSpec.feature "user can login with github" do

  scenario "non logged in user authenticates with github" do
    stub_omniauth
    visit root_path
    expect(page).to_not have_content("Kerry Sheldon")
    expect(page).to have_button("Login with Github")
    click_button "Login with Github"
    expect(current_path).to eq(dashboard_index_path)
    within("nav") do
      expect(page).to have_content("Welcome, Kerry Sheldon")
      expect(page).to have_link("Logout")
    end
  end

  scenario "logged in user is redirected to dashboard" do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )
    visit root_path
    expect(current_path).to eq(dashboard_index_path)
    within("nav") do
      expect(page).to have_content("Welcome, Kerry Sheldon")
      expect(page).to have_link("Logout")
    end
  end

  scenario "logged in can logout" do
    stub_omniauth
    visit root_path
    click_button "Login with Github"
    expect(current_path).to eq(dashboard_index_path)
    within("nav") do
      click_link "Logout"
    end
    expect(current_path).to eq(root_path)
    expect(page).to_not have_content("Kerry Sheldon")
    expect(page).to have_button("Login with Github")
  end

end
