require 'rails_helper'

RSpec.feature "User can seach quizlet" do
  scenario "user enters search term and gets results" do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit quizlet_index_path
    click_on "Search Quizlet"
    expect(current_path).to equal "/quizlet/search"
    fill_in(:q), with: "SQL"
    click_on "Search"

    expect(page).to have_content("Quizlet Search Results:")
    # within(".search-1") do
    #   #content
    # end
  end

end
