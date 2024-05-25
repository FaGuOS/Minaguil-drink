class AddPersonalIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :personal_id, :integer, null: false, unique: true
    add_index :users, :personal_id, unique: true
  end
end
