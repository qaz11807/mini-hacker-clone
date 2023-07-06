# frozen_string_literal: true

module MockHelper
  def mock_account
    @app = FactoryBot.create(:doorkeeper_application)
    @user = FactoryBot.create(:user)
    @token = @user.generate_access_token(@app.id, @app.scopes).token
  end
end
