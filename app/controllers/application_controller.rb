class ApplicationController < ActionController::Base
    before_action :set_global_data
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception, prepend: true
    
    def set_global_data
        @categories=Category.all
        @books=Book.all
        @books.each do |book|
            book.update_attribute "tviews", book.get_views
            book.update_attribute "tsubs", book.subscriptions.count()
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end
    
    
    
end
