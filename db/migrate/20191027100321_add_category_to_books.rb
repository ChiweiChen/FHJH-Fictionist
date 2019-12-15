class AddCategoryToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :category, :string
  end
end
