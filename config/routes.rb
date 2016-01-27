Rails.application.routes.draw do
  root 'static#home'
  resources :users, only: [] do
    collection do
      get :facebook_auth
      post :message
    end
  end
end
