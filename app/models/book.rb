class Book < ApplicationRecord
    has_many :chapters
    has_and_belongs_to_many :categories
    has_many :subscriptions
    has_many :users, through: :subscriptions 
    has_one_attached :cover

    def check_subscriber(user_id)
        users.pluck("id").include?(user_id)
    end

    def get_author
        if(self.chapters.first.user_ids[0]!=nil)
            return User.find(self.chapters.first.user_ids[0]).name
        end
        
            
    end
    
    def get_cover
        if self.cover.attached?
            Rails.application.routes.url_helpers.rails_blob_path(self.cover, only_path:true)
        else
            "http://placehold.it/600x800"
        end
    end

    def get_categories
        self.categories
    end
end
