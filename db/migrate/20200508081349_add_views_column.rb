class AddViewsColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :views, :integer, default: 0
  end
end
