require 'rails_helper'

RSpec.feature "user can follow someone from public profile" do
  scenario "follows someone" do
    user, other_user = create_list(:user, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    expect(other_user.followers.count).to eq(0)
    visit "/users/#{other_user.nickname}"
    within ".followers" do
      expect(page).to have_content("0")
    end
    expect(page).to_not have_content("Unfollow") #does this need to be a button?
    click_on "Follow"
    expect(page).to have_content("Unfollow")
    expect(page).to_not have_button("Follow") #not sure this is a function
    within ".followers" do
      expect(page).to have_content("0")
    end
    expect(other_user.followers.count).to eq(1)
  end

  scenario "unfollows someone" do
    user, other_user = create_list(:user, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )
    other_user.user_followers.create(follower: user)
    expect(other_user.followers.count).to eq(1)
    visit "/users/#{other_user.nickname}"
    within ".followers" do
      expect(page).to have_content("1")
      xpect(page).to have_content(user.nickname)
    end
    click_on "Unfollow"
    expect(page).to have_content("Follow")
    expect(page).to_not have_button("Unfollow") #not sure this is a function
    within ".followers" do
      expect(page).to have_content("0")
      expect(page).to_not have_content(user.nickname)
    end
    expect(other_user.followers.count).to eq(1)
  end
end
