Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'tasks/archive' => 'tasks#archive'
  get 'signup' => 'users#new'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :tasks, only: [:index, :show, :new, :create]
  root 'tasks#index'

  # add this line to link tags to posts with the respective tag
  get 'tags/:tag', to: 'tasks#index', as: :tag
  resources :tasks do
    member do
      patch :complete
    end
    resources :subtasks do
      member do
        patch :complete
      end
    end
  end

  get 'tags' => 'tasks#index'
  patch 'tasks/:id/edit' => 'tasks#update'
end
