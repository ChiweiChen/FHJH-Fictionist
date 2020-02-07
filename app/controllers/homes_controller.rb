class HomesController < ApplicationController
    def user
        @pieces = []
        chapters = current_user.chapters.where(is_first: true)
        chapters.each do |chapter|
            @pieces.push(chapter.book)
        end
    end

    def index
        a=Date.today.wday
        @todays=[]
        Book.all.each do |book|
            if(book.id%7==a)
                @todays.push(book)
            end
        end
    end
end
