require 'rails_helper'

RSpec.feature "User sees recent activity" do
  scenario "user sees activity" do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )
    create_list(:skill, 5)
    create_list(:current_goal, 5)
    create_list(:session, 10)
    create_list(:skill, 5)

    visit dashboard_index_path
    click_on "Recent Activity"
    expect(current_path).to eq(activity_index_path)

    expect(page).to have_content("added skill")
    expect(page).to have_content("completed a 15 minute practice session of for the following skill")

  end


end
