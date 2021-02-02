Rails.application.routes.draw do
  root 'home#index'
  resources :promotions do
    get 'search', on: :collection
    post 'generate_coupons', on: :member
  end
end
