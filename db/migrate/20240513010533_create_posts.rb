class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :review
      t.integer :yes
      t.integer :nonsence

      t.timestamps
    end
  end
end
