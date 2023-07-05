# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/user#register', type: :request do
  before(:each) do |example|
    @headers = {
      'Content-Type': 'application/json'
    }
    @params = {
      email: 'new_email@gmail.com',
      password: 'rootroot'
    }
    @path = '/api/v1/user/register'
  end

  describe 'Post users/register' do
    it 'should return code 200' do |example|
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 400 if email is not valid' do |example|
      @params[:email] = 'test.acc'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_002)
    end

    it 'should return code 400 if email already used' do |example|
      @params[:email] = @user.email

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(400)
      expect(json['error_code']).to eq(400_005)
    end
  end
end
