# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/posts#index', type: :request do
  before(:each) do |example|
    @posts = create_list(:post, 20, user: @user)

    @path = '/api/v1/posts'
  end

  describe 'Get all posts' do
    it 'should return code 200' do |example|
      get(@path)
      expect(response).to have_http_status(:ok)
    end

    it 'should return code 200 with pagination' do |example|
      params = {
        page: 1,
        per_page: 5
      }

      get(@path, params: params)
      expect(response).to have_http_status(:ok)
      expect(json['data']['posts'].length).to eq(params[:per_page])
    end
  end
end
