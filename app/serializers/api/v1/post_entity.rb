class Api::V1::PostEntity < BaseEntity
  expose :id, :title, :weight, :url, :comments_count, :created_at
  expose :author, using: Api::V1::UserEntity do |post|
    post.user
  end

  expose :voted
  expose :comments, if: ->(_, options) { options[:comments] }

  private

  alias post object

  def comments
    options[:comments].arrange_serializable do |parent, children|
      Api::V1::CommentEntity.represent(parent, options.merge({ children: children }))
    end
  end

  def voted
    return false unless options[:current_user]

    post.votes.pluck(:user_id).include?(options[:current_user].id)
  end
end
