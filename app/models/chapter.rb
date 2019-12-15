class Chapter < ApplicationRecord
    belongs_to :book
    belongs_to :users
end
