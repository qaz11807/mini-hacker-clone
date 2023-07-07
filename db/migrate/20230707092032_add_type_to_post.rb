class AddTypeToPost < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.integer :post_type, default: 0
    end
  end
end
