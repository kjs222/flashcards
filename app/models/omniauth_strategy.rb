require 'omniauth'
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Quizlet < OmniAuth::Strategies::OAuth2
      option :name, "quizlet"

      option :client_options, {
        :site => 'https://api.quizlet.com',
        :authorize_url => 'https://quizlet.com/authorize/',
        :token_url => 'https://api.quizlet.com/oauth/token'
      }

      option :authorize_params, {:response_type => "code"}
      option :authorize_options, [:scope, :state]

      uid { raw_info["username"] }

      info do
        {

        }
      end

      extra do
        {'raw_info' => raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get("/2.0/users/#{access_token.params["user_id"]}").parsed
      end
    end
  end
end
