class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.integer :post_id

      t.timestamps
    end
  end
end
