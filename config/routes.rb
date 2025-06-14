Rails.application.routes.draw do
  root "pages#index"

  namespace :api do
    namespace :v1 do
      resources :airlines, param: :slug
      resources :reviews, only: [ :create, :destroy ]
    end
  end

  get "*path", to: "pages#index", via: :all # Redirect innexisitng URLs to index route. Useful when handling with React Router components without interfering with Rails routes
end
