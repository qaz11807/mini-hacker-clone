class HelloController < ApplicationController
  def index
    render status: 200, json: { data: 'hello world!' }
  end
end
