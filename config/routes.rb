Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  get "help" => "static_pages#help"
  namespace :admin do
    root "static_pages#home"
    resources :users, except: :show
    resources :courses do
      resource :assign_trainees, only: [:edit, :update]
    end
    resources :subjects, except: :show
    resources :user_courses, only: :destroy
  end
  namespace :supervisor do
    resources :course_subjects, only: [:update, :index, :show]
    resources :courses, only: [:show, :index, :update]
    resources :courses, only: :show do
      resource :add_user_courses, only: [:edit, :update]
      resources :course_subjects, only: :show
    end
  end
end
