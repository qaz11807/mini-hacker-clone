# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/posts#add_comment', type: :request do
  before(:each) do |example|
    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      text: 'comment'
    }

    @post = create(:post, user: @user)

    @path = "/api/v1/posts/#{@post.id}/comments"
  end

  describe 'add comment to the post' do
    it 'should return code 200' do |example|
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)

      expect(
        @post.comments.find_by(user: @user)
      ).to be_present
    end

    it 'should create new comment' do |example|
      expect { post(@path, headers: @headers, params: @params.to_json) }
        .to change(Comment, :count).by(+1)
    end

    it 'should return code 404 if posts not found' do |example|
      @path = '/api/v1/posts/9999/comments'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_001)
    end
  end
end
