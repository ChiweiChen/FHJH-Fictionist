class Chapter < ApplicationRecord
    belongs_to :book
    has_and_belongs_to_many :users
    scope :uploaded, -> { where('upload is not null') }
    
    
end
