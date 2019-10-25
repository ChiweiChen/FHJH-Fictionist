Rails.application.routes.draw do
  resources :comments
  resources :likes
  resources :books
  resources :chapters

  root 'homes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
