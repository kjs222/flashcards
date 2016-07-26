require 'rails_helper'

RSpec.feature "user can login with quizlet" do
  include Capybara::DSL
  def setup
    Capybara.app = Apicurious::Application
    stub_omniauth
  end

  scenario "user authenticates with quizlet" do
    visit root_path
    page.should have_content("Login on Quizlet")
    click_link "Login on Quizlet"
    page.should have_content("kjs222")  # user name
    # page.should have_css('img', :src => 'mock_user_thumbnail_url') # user image
    page.should have_content("Log out")
  end

  # it "can handle authentication error" do
  #   OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  #   visit '/'
  #   page.should have_content("Sign in with Twitter")
  #   click_link "Sign in"
  #   page.should have_content('Authentication failed.')
  # end


end
