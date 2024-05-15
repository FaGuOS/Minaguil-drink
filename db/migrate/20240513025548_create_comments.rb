class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :comment_1
      t.string :comment_2

      t.timestamps
    end
  end
end
