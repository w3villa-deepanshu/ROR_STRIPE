Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords'

  }
root 'home#index'
  resources :workshops, only: [:index,:show]
  resources :bookings,only: [:create] do
    get :booking_details, on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
