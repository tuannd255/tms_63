Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  get "help" => "static_pages#help"
  namespace :admin do
    root "static_pages#home"
    resources :users, except: :show
    resources :subjects, only: [:create, :new, :index]
  end
end
