# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/comments#add_comment', type: :request do
  before(:each) do |example|
    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }
    @params = {
      text: 'you are right'
    }

    @comment = create(:comment, :with_post, user: @user)

    @path = "/api/v1/comments/#{@comment.id}/comments"
  end

  describe 'reply the comment' do
    it 'should return code 200' do |example|
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)

      expect(
        @comment.comments.find_by(user: @user)
      ).to be_present
    end

    it 'should create new comment' do |example|
      expect { post(@path, headers: @headers, params: @params.to_json) }
        .to change(Comment, :count).by(+1)
    end

    it 'should return code 404 if comment not found' do |example|
      @path = '/api/v1/comments/9999/comments'

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(404)
      expect(json['error_code']).to eq(404_002)
    end
  end
end
