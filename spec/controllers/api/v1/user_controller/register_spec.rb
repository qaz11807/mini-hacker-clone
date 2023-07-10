# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/user#register', type: :request do
  before(:each) do
    @headers = {
      'Content-Type': 'application/json'
    }
    @params = {
      email: 'new_email@gmail.com',
      password: 'rootroot',
      client_id: @app.uid,
      client_secret: @app.secret
    }
    @path = '/api/v1/user/register'
  end

  describe 'Post users/register' do
    it 'should return code 200' do
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 400 if email is not valid' do
      @params[:email] = 'test.acc'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_002)
    end

    it 'should return code 400 if email already used' do
      @params[:email] = @user.email

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_005)
    end
  end
end
