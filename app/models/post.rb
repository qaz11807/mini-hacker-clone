class Post < ApplicationRecord
  has_many :comments
  has_many :votes, as: :votable
  belongs_to :user

  enum post_type: { story: 0, job: 1 }

  include Weighable
end
