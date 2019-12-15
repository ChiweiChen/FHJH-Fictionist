class AlterTables1207Meeting < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :cover, :string
    add_column :chapters, :upload, :datetime
    add_column :chapters, :views, :integer
  end
end
