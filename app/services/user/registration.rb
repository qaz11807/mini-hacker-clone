class User::Registration < ServiceCaller
  def initialize(application_id, user_info)
    @application_id = application_id
    @user_info = user_info
  end

  def call
    check_email_format
    check_email_exist
    setup_user
    generate_token

    @result = @user
  end

  private

  def check_email_format
    raise ServiceError.new(:invalid_email) unless @user_info[:email].match?(URI::MailTo::EMAIL_REGEXP)
  end

  def check_email_exist
    @user = User.find_by(email: @user_info[:email])
    raise ServiceError.new(:email_already_registered) if @user.present?
  end

  def setup_user
    @user = User.new
    @user.assign_attributes(@user_info)
    @user.save!
  end

  def generate_token
    @user.access_tokens.create(
      application_id: @application_id,
      use_refresh_token: true,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )
  end
end
