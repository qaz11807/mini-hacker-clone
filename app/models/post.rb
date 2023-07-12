class Post < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  belongs_to :user

  enum post_type: { story: 0, job: 1 }

  include Weighable

  def nested_comments(with_voted: false)
    associtaions = [:user]
    associtaions << :votes if with_voted
    comments.sort_by_weight.map { |comment| comment.subtree.eager_load(associtaions).sort_by_weight }
  end
end
