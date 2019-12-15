class AddShowToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :show, :string
  end
end
