Rails.application.routes.draw do
  namespace :v1 do
    namespace :webhooks do
      resources :reservations, only: [:create, :index]
    end
  end
end
