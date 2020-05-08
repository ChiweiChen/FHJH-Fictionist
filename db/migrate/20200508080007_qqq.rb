class Qqq < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :views
  end
end
