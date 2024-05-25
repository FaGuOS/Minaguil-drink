class AddHiddenToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :hidden, :boolean, default: false
  end
end
