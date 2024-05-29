class AddPostIdToComments < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:comments, :post_id)
      add_reference :comments, :post, null: false, foreign_key: true
    end
  end
end
