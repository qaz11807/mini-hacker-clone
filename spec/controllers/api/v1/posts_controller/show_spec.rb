# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/posts#show', type: :request do
  before(:each) do
    @headers = {
      'Authorization': "Bearer #{@token}"
    }

    @post = create(:post, :with_comments, user: @user)
    @voted_comment = @post.comments.first
    create(:vote, user: @user, comment: @voted_comment)

    @path = "/api/v1/posts/#{@post.id}"
  end

  describe 'Get post with comments' do
    it 'should return code 200' do
      get(@path)
      expect(response).to have_http_status(:ok)
      expect(json['data']['id']).to be_present
      expect(json['data']['comments']).to_not be_empty
    end

    it 'the comments should be nested' do
      get(@path)
      expect(response).to have_http_status(:ok)
      expect(
        json['data']['comments'].first
      ).to_not be_empty
    end

    it 'the cooment should with voted if request has token' do
      get(@path, headers: @headers)
      expect(response).to have_http_status(:ok)
      expect(
        json['data']['comments'].flatten.find { |comment| comment['id'] == @voted_comment.id }['voted']
      ).to eq(true)
    end
  end
end
