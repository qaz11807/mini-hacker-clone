class Post < ApplicationRecord
  has_many :comments, as: :commentable
  belongs_to :user

  enum post_type: { story: 0, job: 1 }

  def nested_comments
    comments.first.descendants
  end
end
