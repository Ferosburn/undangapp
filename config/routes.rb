Rails.application.routes.draw do
  post 'recipients/:event_id/create' => 'recipients#create'
  get 'recipients/:event_id/:id/delete' => 'recipients#delete_recipient'

  post 'events/create' => 'events#create'
  get 'events/new' => 'events#new'
  get 'events/index' => 'events#index'
  get 'events/:id' => 'events#show'
  post 'events/:id/update' => 'events#update'
  get 'events/:id/edit' => 'events#edit'
  get 'events/:id/delete' => 'events#delete'
  get 'events/:id/:converted_name_for_link' => 'events#invitation'

  get 'dashboard/:id' => 'users#show'
  post 'users/create' => 'users#create'
  get 'signup' => 'users#new'
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  get 'logout' => 'users#logout'

  get '/' => 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
