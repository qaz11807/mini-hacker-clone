class Api::V1::AccessTokenEntity < BaseEntity
  expose :token, :expires_in, :refresh_token, :token_type, :expires_in

  expose :created_at

  private

  def token_type
    'bearer'
  end

  def created_at
    @created_at ||= object[:created_at].to_time.to_i
  end
end
