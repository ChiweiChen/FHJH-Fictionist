class Comment < ApplicationRecord
    def get_author
        self.user_id
    end
end
