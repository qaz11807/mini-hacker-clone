class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.float :weight
      t.integer :voted
      t.references :post, null: false, foreign_key: true
      t.timestamps

      t.string "ancestry", collation: 'C', null: false
      t.index "ancestry"
    end
  end
end
