require 'rails_helper'

RSpec.feature "user can get to another user's profile from activity log" do

  scenario "user gets to public profile" do
    user, other_user = create_list(:user, 2)
    create(:skill, user: other_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit activity_index_path
    click_on other_user.name
    expect(current_path).to eq(user_path(other_user.nickname))
  end

end
