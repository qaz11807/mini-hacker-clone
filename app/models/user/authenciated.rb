class User
  module Authenciated
    def generate_access_token(app_id, scopes = '')
      access_tokens.create(
        application_id: app_id,
        refresh_token: generate_refresh_token,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        scopes: scopes
      )
    end

    private

    def generate_refresh_token
      loop do
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
      end
    end
  end
end
