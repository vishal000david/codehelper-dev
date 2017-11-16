Rails.application.routes.draw do
  

  get 'members/index'

  get 'members/create'

  get 'members/new'

  root to: 'home#index' 

  resources :stores

  devise_for :users, :controllers => { registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
