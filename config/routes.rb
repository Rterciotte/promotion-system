Rails.application.routes.draw do
  root 'home#index'
  resources :promotions do
    get 'search', on: :collection
  end
end
