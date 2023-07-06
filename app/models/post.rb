class Post < ApplicationRecord
  def comments
    comment = Comment.find_by(post_id: id)
    return unless comment.has_children?

    comment.descendants
  end
end
