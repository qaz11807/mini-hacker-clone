class RenameCommentTitle < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :title, :text
  end
end
