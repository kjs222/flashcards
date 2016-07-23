require 'omniauth'
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Quizlet < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "quizlet"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => 'https://api.quizlet.com',
        :authorize_url => 'https://quizlet.com/authorize/',
        :token_url => 'https://api.quizlet.com/oauth/token'
      }

      option :authorize_params, {:response_type => "code"}
      option :authorize_options, [:scope, :state]

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info["username"] }

      info do
        {
          "username" => raw_info["username"],
          "account_type" => raw_info["account_type"],
          "sign_up_date" => raw_info["sign_up_date"],
          "profile_image" => raw_info["profile_image"]
        }
      end

      extra do    
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/2.0/users/#{access_token.params["user_id"]}").parsed
        # @raw_info ||= access_token.get('/auth/quizlet').parsed
      end
    end
  end
end
