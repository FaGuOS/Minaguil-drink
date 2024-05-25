class RemoveYesFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :yes, :integer
  end
end
