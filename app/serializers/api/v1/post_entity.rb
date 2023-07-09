class Api::V1::PostEntity < BaseEntity
  expose :id, :title, :weight, :url, :descendants
  expose :author, using: Api::V1::UserEntity do |post|
    post.user
  end

  expose :comments, if: { with_comments: true }

  private

  alias post object

  def comments
    post.nested_comments(with_voted: options[:current_user].present?).map do |comment|
      comment.arrange_serializable do |parent, children|
        Api::V1::CommentEntity.represent(parent, options.merge({ children: children }))
      end
    end.flatten
  end
end