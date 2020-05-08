class ChaptersViews < ActiveRecord::Migration[6.0]
  def change
    remove_column :chapters, :views
    add_column :chapters, :views, :integer, default: 0
  end
end
