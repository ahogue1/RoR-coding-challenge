Rails.application.routes.draw do

  root to: 'banner_people#index'
  resources :banner_people, only: [:index, :show, :update]
end
