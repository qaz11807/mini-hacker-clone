class ReviseToVotable < ActiveRecord::Migration[7.0]
  def change
    remove_column :votes, :comment_id

    change_table :votes do |t|
      t.string :votable_type
      t.integer :votable_id
    end

    add_column :posts, :votes_count, :integer, default: 0
  end
end
