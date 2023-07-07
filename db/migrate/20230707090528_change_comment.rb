class ChangeComment < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :post, foreign_key: true

    change_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
    end
  end
end
