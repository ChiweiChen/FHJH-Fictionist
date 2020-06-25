Rails.application.routes.draw do
  devise_for :users
  
  resources :comments
  resources :likes
  resources :chapters do
    member do
      post :unsend
      post :upload
    end
  end
  resources :books do
    member do 
      get :dashboard
      post :subscribe
      post :unsubscribe
      
    end
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
  get '/user', to: 'homes#user'
  get '/admin', to: 'homes#admin'
  get '/search', to: 'books#search'
  get '/helpcenter', to: 'homes#helpcenter'
  get '/help_1-1', to: 'homes#help_1-1'
  get '/help_1-2', to: 'homes#help_1-2'
  get '/help_1-3', to: 'homes#help_1-3'
  get '/help_1-4', to: 'homes#help_1-4'
  get '/help_1-5', to: 'homes#help_1-5'
  get '/help_1-6', to: 'homes#help_1-6'
  get '/help_2-1', to: 'homes#help_2-1'
  get '/help_2-2', to: 'homes#help_2-2'
  get '/help_2-3', to: 'homes#help_2-3'
  get '/help_2-4', to: 'homes#help_2-4'
  get '/help_2-5', to: 'homes#help_2-5'
  get '/help_2-6', to: 'homes#help_2-6'
  get '/help_2-7', to: 'homes#help_2-7'
  get '/help_2-8', to: 'homes#help_2-8'
  get '/help_2-9', to: 'homes#help_2-9'
  get '/help_2-10', to: 'homes#help_2-10'
  get '/help_2-11', to: 'homes#help_2-11'
  
  
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
