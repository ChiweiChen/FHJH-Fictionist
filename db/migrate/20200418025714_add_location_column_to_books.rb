class AddLocationColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :location, :integer
  end
end
