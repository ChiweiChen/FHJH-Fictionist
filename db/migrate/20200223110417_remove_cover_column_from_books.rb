class RemoveCoverColumnFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :cover
  end
end
