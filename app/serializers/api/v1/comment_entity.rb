class Api::V1::CommentEntity < BaseEntity
  expose :id, :text, :weight, :votes_count, :created_at
  expose :children_count, as: :comments_count
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

    comment.votes.pluck(:user_id).include?(options[:current_user].id)
  end
end
