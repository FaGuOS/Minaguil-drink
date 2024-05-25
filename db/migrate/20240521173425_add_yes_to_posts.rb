class AddYesToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :yes, :integer, default: 0, null: false
  end
end
