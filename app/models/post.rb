class Post < ApplicationRecord
  has_many :comments, as: :commentable
  belongs_to :user

  enum post_type: { story: 0, job: 1 }

  include Weighable

  def nested_comments(with_voted: false)
    associtaions = [:user]
    associtaions << :votes if with_voted
    comments.map { |comment| comment.subtree.eager_load(associtaions).order(weight: :desc) }
  end
end
