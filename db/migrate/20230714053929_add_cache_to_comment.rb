class AddCacheToComment < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.integer :ancestry_depth, default: 0
      t.integer :children_count, default: 0
    end
  end
end
