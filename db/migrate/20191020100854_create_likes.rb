class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.boolean :status
      t.integer :user_id
      t.integer :chapter_id

      t.timestamps
    end
  end
end
