class Comment < ApplicationRecord
  has_ancestry cache_depth: true, counter_cache: true

  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :votes, as: :votable

  include Weighable
end
