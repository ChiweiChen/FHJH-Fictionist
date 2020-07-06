class Book < ApplicationRecord
    has_many :chapters, :dependent => :destroy
    has_and_belongs_to_many :categories
    has_many :subscriptions, :dependent => :destroy
    has_many :users, through: :subscriptions 
    has_one_attached :cover, :dependent => :destroy

    validate :check_file_type

   

    def check_file_type
        if cover.attached? && !cover.content_type.include?('image')
            cover=nil #change the file to nil
            errors.add(:cover, '必須要是圖片')
        end
    end

    def check_subscriber(user_id)
        users.pluck("id").include?(user_id)
    end

    def get_author
        begin
            if(self.chapters.first.user_ids[0]!=nil)
                return User.find(self.chapters.first.user_ids[0]).name
            end
        rescue
        end
        
            
    end
    
    def get_cover
        if self.cover.attached?
            Rails.application.routes.url_helpers.rails_blob_path(self.cover, only_path:true)
        else
            "https://via.placeholder.com/600x800/000000/0FF0F0/?text=sorry,%20no%20cover%20yet"
        end
    end

    def get_categories
        self.categories
    end

    def get_views
        views=self.views
        self.chapters.each do |chapter|
            views+=chapter.views
        end
        return views
    end
end
