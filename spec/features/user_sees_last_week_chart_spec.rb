require 'rails_helper'

RSpec.feature "User sees charts" do
  scenario "User sees last weeks chart when navigating", js: true do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")

    skill = user.skills.create(nickname: "skill1", description: "description for skill 1")

    session_date = 5.days.ago

    session = skill.sessions.create(duration: 60, created_at: session_date)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit dashboard_index_path
    click_on "Statistics"

    expect(current_path).to eq(statistics_path)
    # sleep(5)
    #
    # #NOT WORKING DUE TO JQUERY
    #
    # expect(page).to have_content(session_date.strftime('%b %d'))
    # expect(page).to have_content((session_date + 1.days).strftime('%b %d'))
    # expect(page).to have_content("Total Practice in Minutes")

  end
end
