class ApplicationController < ActionController::Base
    def _nav
        @categories=Category.All
    end
end
