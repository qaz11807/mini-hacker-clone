require 'rails_helper'

RSpec.describe '/', type: :request do
  before(:each) do |example|
    @path = '/'
  end

  describe 'Api Test' do
    it 'should return code 200' do |example|
      get(@path)
      expect(response).to have_http_status(:ok)
    end
  end
end
