# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/posts#create', type: :request do
  before(:each) do
    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      title: 'Test news',
      url: 'https://news.ycombinator.com',
    }

    @path = '/api/v1/posts'
  end

  describe 'create new post' do
    it 'should return code 200' do
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)
    end

    it 'should create new post' do
      expect { post(@path, headers: @headers, params: @params.to_json) }
        .to change(Post, :count).by(+1)
    end
  end
end
