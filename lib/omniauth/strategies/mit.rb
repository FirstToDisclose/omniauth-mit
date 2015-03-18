require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MIT < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://oidc.mit.edu/',
        :authorize_url => 'https://oidc.mit.edu/authorize',
        :token_url => 'https://oidc.mit.edu/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname' => raw_info['preferred_username'],
          'email' => raw_info['email'],
          'name' => raw_info['name'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'mit', 'MIT'
