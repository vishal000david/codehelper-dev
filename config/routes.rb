Rails.application.routes.draw do
  

  get 'members/index'

  get 'members/create'

  get 'members/new'

  post '/give_perm' => 'stores#give_perm'

  root to: 'stores#index' 

  get 'select_folder' => "stores#select_folder"

  resources :stores

  devise_for :users, :controllers => { registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
