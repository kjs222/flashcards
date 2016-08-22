require 'rails_helper'

RSpec.feature "User sees associated users on community" do

  scenario "user sees followers and following" do
    user, follower, user_followed = create_list(:user, 3)
    user.user_followers.create(follower: follower)
    UserFollower.create(user: user_followed, follower: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path

    click_on("Community")
    expect(current_path).to eq(community_path)

    within('.community-followers') do
      expect(page).to have_content(follower.nickname)
    end

    within('.community-following') do
      expect(page).to have_content(user_followed.nickname)
    end

    click_on(user_followed.nickname)

    expect(current_path).to eq(user_path(user_followed.nickname))

  end
end
