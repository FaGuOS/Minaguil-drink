class DropLikesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :likes
  end

  def down
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :value, default: 0, null: false

      t.timestamps
    end
  end
end
