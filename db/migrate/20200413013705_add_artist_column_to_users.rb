class AddArtistColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :artist, :string, default: 'not'
  end
end
