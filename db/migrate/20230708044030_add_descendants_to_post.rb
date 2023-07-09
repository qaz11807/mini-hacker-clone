class AddDescendantsToPost < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.integer :descendants, default: 0
    end

    Post.find_each(batch_size: 100) do |post|
      descendants = post.comments.reduce(0) do |acc, comment|
        acc + comment.subtree.count
      end
      post.update!(descendants: descendants)
    end
  end
end
