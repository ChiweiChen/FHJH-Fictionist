class RemoveChapterUserIdAddUserChapterTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :chapters, :users
    remove_column :chapters, :user_id
  end
end
