class Api::V1::UserController < Api::V1::ApplicationController
  before_action :setup_application

  def register
    registration = User::Registration.call(@application.id, user_params)
    return error_response(registration.error.key) if registration.failed?

    serialize_response(:user, registration.result, with_token: true)
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def setup_application
    @application = Doorkeeper::Application.find_by(uid: params[:client_id], secret: params[:client_secret])
    return error_response(:invalid_client) if @application.nil?
  end
end
