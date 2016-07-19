Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  get "help" => "static_pages#help"
  namespace :admin do
    root "static_pages#home"
    resources :users, except: :show
    resources :courses
    resources :subjects, except: :show
  end
  namespace :supervisor do
    resources :courses, only: [:show, :index]
    resources :courses, only: :show do
      resource :add_user_courses, only: [:edit, :update]
    end
  end
end
