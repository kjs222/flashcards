require 'rails_helper'

RSpec.feature "User sees correct info on public profiles" do

  scenario "User sees correct info on his own profile" do

    user, follower, user_followed = create_list(:user, 3)
    user.user_followers.create(follower: follower)
    UserFollower.create(user: user_followed, follower: user)
    skill = create(:skill, user: user)
    session = create(:session, skill: skill)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit account_path
    click_on("View")

    expect(current_path).to eq(user_path(user.nickname))
    expect(page).to_not have_selector(".follow-container")

    within("#followers-count") do
      expect(page).to have_content(1)
    end

    within("#following-count") do
      expect(page).to have_content(1)
    end

    within(".recent-activity") do
      expect(page).to have_content(skill.nickname)
      expect(page).to have_content(session.duration)
    end

    expect(page).to have_button("Show Skills")
    expect(page).to have_button("Show Followers")
    expect(page).to have_button("Show Following")

  end

  scenario "User sees correct info on profile of someone he follows" do

    user, follower, user_followed = create_list(:user, 3)
    user.user_followers.create(follower: follower)
    UserFollower.create(user: user_followed, follower: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit(user_path(user_followed.nickname))

    expect(page).to have_content(user_followed.name)
    expect(page).to have_content(user_followed.nickname)

    within(".follow-container") do
      expect(page).to_not have_button("Follow")
      expect(page).to have_button("Unfollow")
    end

    within("#followers-count") do
      expect(page).to have_content(1)
    end

    within("#following-count") do
      expect(page).to have_content(0)
    end

    within(".recent-activity") do
      expect(page).to have_content("No practice sessions.")
    end

    expect(page).to have_button("Show Skills")
    expect(page).to have_button("Show Followers")
    expect(page).to_not have_button("Show Following")
  end

  scenario "User sees correct info on profile of someone he does not follow" do

    user, follower, user_followed = create_list(:user, 3)
    user.user_followers.create(follower: follower)
    UserFollower.create(user: user_followed, follower: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit(user_path(follower.nickname))

    expect(page).to have_content(follower.name)
    expect(page).to have_content(follower.nickname)

    within(".follow-container") do
      expect(page).to have_button("Follow")
      expect(page).to_not have_button("Unfollow")
    end

    within("#followers-count") do
      expect(page).to have_content(0)
    end

    within("#following-count") do
      expect(page).to have_content(1)
    end

    within(".recent-activity") do
      expect(page).to have_content("No practice sessions.")
    end

    expect(page).to_not have_button("Show Followers")

    expect(page).to have_button("Show Following")

  end

end
