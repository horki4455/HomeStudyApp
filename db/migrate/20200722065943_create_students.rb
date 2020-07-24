class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :image
      t.string :subject
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
