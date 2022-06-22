Rails.application.routes.draw do
  # devise_for :admin_users
  devise_for :admin_users, controllers: {
    sessions: 'admin_user/sessions',
    passwords: 'admin_user/passwords'

  }
  root 'home#index'
  resources :workshops, only: [:index,:show]
  resources :bookings,only: [:create] do
    get :booking_details, on: :member
  end
  namespace :admin do
    get 'dashboard' => 'dashboard#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
