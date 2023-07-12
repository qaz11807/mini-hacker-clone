class Api::V1::UserEntity < BaseEntity
  expose :email

  expose :token_info, if: { with_token: true }, using: Api::V1::AccessTokenEntity do |user|
    user.access_tokens.last
  end
end
