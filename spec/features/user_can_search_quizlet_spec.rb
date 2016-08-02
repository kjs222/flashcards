require 'rails_helper'

RSpec.feature "User can seach quizlet" do
  scenario "user enters search term and gets results" do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit quizlet_index_path
    fill_in :q, with: "SQL"

    fill_in :created_by, with: "kjs222"
    click_on "Search"

    expect(current_path).to eq(quizlet_search_path)

    expect(page).to have_content("Quizlet Search Results")
    expect(page).to have_content("SQL")
    expect(page).to have_content("kjs222")


  end

end
