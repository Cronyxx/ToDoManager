Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'signup' => 'users#new'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :tasks
  root 'tasks#index'

  # add this line to link tags to posts with the respective tag
  get 'tags/:tag', to: 'tasks#index', as: :tag
end
