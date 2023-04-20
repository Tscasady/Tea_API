Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :customers do
        scope module: :customers do
          resources :subscriptions, only: [:index, :create]
        end
      end
    end
  end
end
