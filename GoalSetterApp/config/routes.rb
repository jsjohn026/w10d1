Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, except: [:destroy, :edit, :update]
  resource :session, only: [:create, :new, :destroy]

end
