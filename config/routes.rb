Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      namespace :user do
        post '/register', action: 'register'
      end

      resources :posts, module: :posts, controller: :base, only: [:index, :create] do
        resources :comments, only: [:create]
      end

      resources :comments, module: :comments, controller: :base, only: [:show] do
        member do
          post '/voted', action: 'add'
        end

        resources :comments, only: [:create]
      end
    end
  end
end
