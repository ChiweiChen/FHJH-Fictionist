class HomesController < ApplicationController
    def user
        @pieces = []
        chapters = current_user.chapters.where(is_first: true)
        chapters.each do |chapter|
            @pieces.push(chapter.book)
        end
    end
end
