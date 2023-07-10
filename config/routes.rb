Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      namespace :user do
        post '/register', action: 'register'
      end

      concern :commentable do
        member do
          post '/comments', action: 'add_comment'
        end
      end

      concern :votable do
        member do
          post '/votes', action: 'vote'
        end
      end

      resources :posts, only: [:index, :show, :create], concerns: [:commentable, :votable]

      resources :comments, only: [], concerns: [:commentable, :votable]
    end
  end
end
