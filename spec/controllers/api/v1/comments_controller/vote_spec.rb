# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/comments#add_comment', type: :request do
  before(:each) do |example|
    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }

    @comment = create(:comment, :with_post, user: @user)

    @path = "/api/v1/comments/#{@comment.id}/votes"
  end

  describe 'vote the comment' do
    it 'should return code 200' do |example|
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)

      expect(
        @comment.votes.find_by(user: @user)
      ).to be_present
    end

    it 'should create new comment' do |example|
      expect { post(@path, headers: @headers, params: @params.to_json) }
        .to change(Vote, :count).by(+1)
    end

    it 'should return code 406_001 if user already voted the comment' do |example|
      create(:vote, user: @user, comment: @comment)

      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(406)
      expect(json['error_code']).to eq(406_001)
    end
  end
end
