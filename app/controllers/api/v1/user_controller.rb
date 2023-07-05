class Api::V1::UserController < Api::V1::ApplicationController
  def register
    registration = User::Registration.call(user_params)
    return error_response(registration.error.key) if registration.failed?

    serialize_response(:user, registration.result)
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
