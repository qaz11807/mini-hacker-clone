# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/oauth/token', type: :request do
  before(:each) do |example|
    @headers = {
      'Content-Type': 'application/json'
    }
    @path = '/oauth/token'
  end

  describe 'Oauth get access_token' do
    it 'should return code 200' do |example|
      params = {
        username: @user.email,
        password: @user.password,
        grant_type: 'password',
        client_id: @app.uid,
        client_secret: @app.secret
      }

      post(@path, headers: @headers, params: params.to_json)
      expect(response).to have_http_status(:ok)
    end
  end
end
