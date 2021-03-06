require 'omniauth_strategy'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :quizlet, ENV['QUIZLET_CLIENT_ID'], ENV['QUIZLET_SECRET'], :scope => "read write_set write_group", :state => "RANDOM_STRING"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "read:org, user,repo,gist"
end
