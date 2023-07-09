class AddExternalId < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :external_id, :integer
    add_column :posts, :external_id, :integer
  end
end
