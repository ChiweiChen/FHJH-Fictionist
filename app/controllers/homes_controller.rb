class HomesController < ApplicationController
    def index
    end
    def about
    end
    def user
        @books=Book.all
    end
end