class HomesController < ApplicationController
    def user
        @pieces = []
        chapters = current_user.chapters.where(is_first: true)
        chapters.each do |chapter|
            @pieces.push(chapter.book)
        end
        
    end

    
    def index
        @all_book_ids=Book.all.ids
        @all_book_ids=@all_book_ids.rotate(Date.today.yday)
        @todays=[]
        i=1
        if Book.all.size<9
            for i in 0..Book.all.size
                @todays.push(Book.find(@all_book_ids[i]))
            end
        else 
            for i in 0..8
                @todays.push(Book.find(@all_book_ids[i]))
            end
        end
        
        
        
    end
end
