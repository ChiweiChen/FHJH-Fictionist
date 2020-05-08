class AddViewsColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :views, :integer
  end
end
