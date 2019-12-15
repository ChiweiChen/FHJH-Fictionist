class CreateBookCategory < ActiveRecord::Migration[6.0]
    def change
      create_join_table :books, :categories
    end
  end