require 'rails_helper'

RSpec.feature "user can add command line capacity to account" do

  scenario "adds command line" do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")
    expect(user.password_digest).to eq(nil)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit account_path
    within (".command-line") do
      expect(page).to have_content("Not Enabled")
      click_button "Enable Command Line App"
    end

    expect(current_path).to eq(edit_user_path(user.id))
    fill_in("user[password]", with: "password")
    click_on "Submit"

    expect(current_path).to eq(account_path)
    within (".command-line") do
      expect(page).to have_content("Activated")
    end
    expect(user.password_digest).to_not eq(nil)
  end

end
