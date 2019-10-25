class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
