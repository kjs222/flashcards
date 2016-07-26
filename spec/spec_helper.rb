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
end


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include StubOmniauth
end
