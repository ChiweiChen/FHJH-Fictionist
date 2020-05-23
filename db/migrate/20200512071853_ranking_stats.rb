class RankingStats < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :tviews, :integer, default: 0
    add_column :books, :tsubs, :integer, default: 0
  end
end
