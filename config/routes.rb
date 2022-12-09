Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "user#index"
  get '/login', to: 'user#login'
  get '/dashboard', to: 'user#dashboard'
  get '/logout', to: 'user#logout'
  get '/new_santa_list', to: 'secret_santa_list#new'
  get '/manage_santa_lists', to: 'secret_santa_list#manage'
  get '/save_list', to: 'secret_santa_list#save'
end
