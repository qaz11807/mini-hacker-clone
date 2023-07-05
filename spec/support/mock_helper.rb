# frozen_string_literal: true

module MockHelper
  def mock_account
    @user = FactoryBot.create(:user)
  end
end
