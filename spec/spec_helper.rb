module StubOmniauth
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "1",
      info: {
        name: "Kerry Sheldon",
        nickname: "kjs222"
            },
      credentials: {
        token: ENV['GITHUB_TOKEN']
                    },
      extra: {
        raw_info: {
          avatar_url: "https://avatars.githubusercontent.com/u/11400778?v=3"
        }
              }
      })
  end

  def stub_quizlet_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:quizlet] = OmniAuth::AuthHash.new({
      provider: 'quizlet',
      uid: 'kjs222',
      credentials: {
        token: ENV['QUIZLET_TOKEN']
        }
      })
  end
end

module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end


require 'selenium/webdriver'

Selenium::WebDriver::Firefox::Binary.path = "/Volumes/Firefox/Firefox.app/Contents/MacOS/firefox"

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before :suite do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.include StubOmniauth
  config.include WaitForAjax, type: :feature
end
