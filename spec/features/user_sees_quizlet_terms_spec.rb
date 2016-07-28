require 'rails_helper'
RSpec.feature "user sees quizlet terms" do
  scenario "terms are shown when clicked" do

     user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

     VCR.use_cassette("my_sets") do
       visit quizlet_index_path
       expect(page).to_not have_content("second
       oauth technical step")
       within("#oauth-technical") do
         click_on "See Terms"
       end
       expect(page).to have_content("second
       oauth technical step")
      
     end
  end
end
