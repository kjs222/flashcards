require 'rails_helper'

RSpec.feature "user can follow someone from public profile" do
  scenario "follows someone" do
    user, other_user = create_list(:user, 2)
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
end
