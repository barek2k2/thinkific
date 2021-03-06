Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  namespace :manage do
    resources :courses do
      resources :chapters do
        resources :contents
        member do
          get :bulk_import
          post :bulk_import
        end
      end
    end
  end
end
