class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.integer :location_id
      t.integer :book_id

      t.timestamps
    end
  end
end
