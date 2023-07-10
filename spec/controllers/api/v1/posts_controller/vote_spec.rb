# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/posts#vote', type: :request do
  before(:each) do
    @headers = {
      'Authorization': "Bearer #{@token}",
      'Content-Type': 'application/json'
    }

    @post = create(:post, user: @user)

    @path = "/api/v1/posts/#{@post.id}/votes"
  end

  describe 'vote the post' do
    it 'should return code 200' do
      post(@path, headers: @headers, params: @params.to_json)
      expect(response).to have_http_status(:ok)

      expect(
        @post.votes.find_by(user: @user)
      ).to be_present
    end

    it 'should create new vote' do
      expect { post(@path, headers: @headers, params: @params.to_json) }
        .to change(Vote, :count).by(+1)
    end

    it 'should return code unvote if user already voted the comment' do
      create(:vote, user: @user, votable: @post)

      expect { post(@path, headers: @headers, params: @params.to_json) }
        .to change(Vote, :count).by(-1)
    end
  end
end
