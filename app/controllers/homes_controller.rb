class HomesController < ApplicationController
    def user
        if current_user==nil
            redirect_to "/"
        elsif current_user.admin? || current_user.artist!='not'
            redirect_to "/admin/"
        end
        if current_user!=nil
            @pieces = []
            chapters = current_user.chapters.where(is_first: true)
            chapters.each do |chapter|
                @pieces.push(chapter.book)
            end
        end
        
    end

    

    def admin
        @books=Book.all
        if current_user==nil
            redirect_to "/"
        else
            if current_user.admin? || current_user.artist!="not"
            else
                redirect_to "/"
            end
        
        end
    end

    
    def index
        @all_book_ids=Book.all.ids
        @all_book_ids=@all_book_ids.rotate(Date.today.yday)
        @todays=[]
        i=1
        if Book.all.size<9
            for i in 0..Book.all.size-1
                @todays.push(Book.find(@all_book_ids[i]))
            end
        else 
            for i in 0..8
                @todays.push(Book.find(@all_book_ids[i]))
            end
        end
        @top_subs=Book.all
        @top_subs.sort_by{|book| book.subscriptions.count()}
        @top_views=Book.all
        @top_subs.sort_by{|book| book.get_views}
        
        
    end
end
