class ApplicationController < ActionController::Base
    before_action :set_global_data

    def set_global_data
        @categories=Category.all
        @books=Book.all
    end
end
