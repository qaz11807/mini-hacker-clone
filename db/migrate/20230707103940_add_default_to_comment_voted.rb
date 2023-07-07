class AddDefaultToCommentVoted < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :voted, 0
  end
end
