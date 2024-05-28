class AddRateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :rate, :integer, default: 0, null: false
  end
end
