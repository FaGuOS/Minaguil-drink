class DropLikesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :likes if ActiveRecord::Base.connection.table_exists?('likes')
  end

  def down
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
