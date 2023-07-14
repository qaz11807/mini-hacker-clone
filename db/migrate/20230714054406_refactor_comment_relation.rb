class RefactorCommentRelation < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type

    change_table :comments do |t|
      t.references :post, null: false, foreign_key: true
    end
  end
end
