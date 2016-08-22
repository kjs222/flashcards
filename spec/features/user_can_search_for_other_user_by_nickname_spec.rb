require 'rails_helper'

RSpec.feature "User can search for other user by nickmame" do

  scenario "user enters nickname of existing user" do
    user, other_user = create_list(:user, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path
    # expect(page).to_not have_content("Search For User")
    click_on("Community")
    expect(page).to have_content("Search For User")

    within(".search-user") do

      fill_in(:user_nickname, with: other_user.nickname)
      click_on "Find User"
    end

    expect(current_path).to eq(user_path(other_user.nickname))


  end

  scenario "user does not enter nickname of existing user" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit community_path

    within(".search-user") do

      fill_in(:user_nickname, with: "notauser")
      click_on "Find User"
    end

    expect(current_path).to eq(community_path)
    expect(page).to have_content("User not found")


  end
end
