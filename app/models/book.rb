class Book < ApplicationRecord
    has_many :chapters
    has_and_belongs_to_many :categories
    
end
