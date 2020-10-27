Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'documents#index'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/profile' => 'users#show', :as => :user 
  get '/profile/edit' => 'users#edit'
  patch '/profile' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#open'
  delete '/logout' => 'sessions#close'

  resources :documents, except: [:new, :edit]
end
