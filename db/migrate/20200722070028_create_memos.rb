class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
