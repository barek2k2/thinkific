class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name, limit: 255
      t.string :subtitle, limit: 255
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.decimal :duration, precision: 5, scale: 1
      t.integer :user_id

      t.timestamps
    end
  end
end
