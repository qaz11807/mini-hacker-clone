class Comment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :votes

  before_create :update_parent
  after_create :update_post_descendants

  include Weighable

  def update_parent
    return unless commentable.instance_of?(Comment)

    self.parent = commentable
  end

  def update_post_descendants
    self.root.commentable.increment!(:descendants)
  end
end
