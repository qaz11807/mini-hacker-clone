Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      namespace :user do
        post '/register', action: 'register'
      end

      resources :posts, only: [:index, :show, :create] do 
        member do
          post '/comments', action: 'add_comment'
        end
      end

      resources :comments, only: [] do
        member do
          post '/comments', action: 'add_comment'
          post '/votes', action: 'vote'
        end
      end
    end
  end
end
