class ChaptersCreateIsFirst < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :is_first, :boolean
  end
end
