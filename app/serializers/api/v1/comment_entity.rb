class Api::V1::CommentEntity < BaseEntity
  expose :id, :text, :weight, :votes_count
  expose :author, using: Api::V1::UserEntity do |comment|
    comment.user
  end

  expose :voted

  expose :comments, if: ->(_, options) { options[:children] } do |_|
    options[:children]
  end

  private

  alias comment object

  def voted
    return false unless options[:current_user]

    comment.votes.pluck(:id).include?(options[:current_user].id)
  end
end