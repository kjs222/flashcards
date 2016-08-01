require 'rails_helper'

RSpec.feature "User sees charts" do
  scenario "User sees last weeks chart when navigating" do

    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com")

    skill = user.skills.create(nickname: "skill1", description: "description for skill 1")

    session_date = 5.days.ago

    session = skill.sessions.create(duration: 60, created_at: session_date)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit statistics_path

    


    # expect(response).to be_success
    #
    # json = JSON.parse(response.body)
    #
    # expect(json.first.count).to eq(13)
    # expect(json.first.include?(session_date.strftime('%B %Y'))).to eq(true)
    #
    # expect(json.last.count(0)).to eq(12)
    # expect(json.last.count(60)).to eq(1)


  end
