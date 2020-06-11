class Chapter < ApplicationRecord
    belongs_to :book
    has_and_belongs_to_many :users
    scope :uploaded, -> { where('upload is not null') }
    
    def has_next
        @all_chapters=self.book.chapters
        @order=@all_chapters.index(self)
        if @order<@all_chapters.size-1 && Chapter.where(id: @all_chapters[@order+1].id)[0].upload!=nil
            return true
        else
            return false
        end
    end

    def has_prev
        @all_chapters=self.book.chapters
        @order=@all_chapters.index(self)
        if @order>0 && Chapter.where(id: @all_chapters[@order-1].id)[0].upload!=nil
            return true
        else
            return false
        end
    end

    def get_next
        @all_chapters=self.book.chapters
        @order=@all_chapters.index(self)
        if self.has_next
            return @all_chapters[@order+1].id
        end
    end

    def get_prev
        @all_chapters=self.book.chapters
        @order=@all_chapters.index(self)
        if self.has_prev
            return @all_chapters[@order-1].id
        end
    end

    def get_comments
        @comments = Comment.where(chapter_id: self.id)
        return @comments
    end
end
