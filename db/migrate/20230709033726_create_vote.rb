class CreateVote < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_column :comments, :votes_count, :integer, default: 0
    remove_column :comments, :voted
  end
end
