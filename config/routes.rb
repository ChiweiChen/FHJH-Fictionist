Rails.application.routes.draw do
  devise_for :users
  
  resources :comments
  resources :likes
  resources :chapters
  resources :books do
    resources :chapters
  end
  resources :users do
    collection do
      get :books
    end
  end
  
#nested routes; nest chapters routes into books routes
#ex. books/{id}/chapters/{id}
  

  root 'homes#index' 
  get '/about', to: 'homes#about'
  get '/contact', to: 'homes#contact'
  get '/user', to: 'homes#user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end