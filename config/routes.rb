Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      namespace :user do
        post '/register', action: 'register'
      end
    end
  end
end
