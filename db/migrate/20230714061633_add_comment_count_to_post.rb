class AddCommentCountToPost < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.integer :comments_count, default: 0
    end

    Post.find_each(batch_size: 100) do |post|
      commentable.update!(comments_count: post.descendants)
    end

    remove_column :posts, :descendants
  end
end
