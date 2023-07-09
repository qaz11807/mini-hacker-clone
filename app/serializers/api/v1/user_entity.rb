class Api::V1::UserEntity < BaseEntity
  expose :email

  expose :access_token, if: { with_token: true }, using: Api::V1::AccessTokenEntity do |user|
    user.access_tokens.last
  end
end
