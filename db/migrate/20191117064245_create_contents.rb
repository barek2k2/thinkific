class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :title, limit: 255
      t.string :content_type
      t.text :description
      t.integer :chapter_id

      t.timestamps
    end
  end
end
