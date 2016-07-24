Rails.application.routes.draw do
  require "sidekiq/web"
  devise_for :users

  root "static_pages#home"

  get "help" => "static_pages#help"
  resources :users, only: :show
  namespace :admin do
    root "static_pages#home"
    authenticate :user, ->u{u.admin?} do
      mount Sidekiq::Web => "/sidekiq"
    end
    resources :users, except: :show
    resources :courses do
      resource :assign_trainees, only: [:edit, :update]
    end
    resources :subjects, except: :show
    resources :user_courses, only: :destroy
  end
  namespace :supervisor do
    resources :course_subjects, only: [:update, :index, :show]
    resources :user_courses, only: :destroy
    resources :users, only: :show
    resources :courses, only: [:show, :index, :update]
    authenticate :user, ->u{u.supervisor?} do
      mount Sidekiq::Web => "/sidekiq"
    end
    resources :courses, only: :show do
      resource :add_user_courses, only: [:edit, :update]
      resources :course_subjects, only: :show
    end
  end
  resources :courses, only: [:show, :index]
  resources :courses, only: :show do
    resources :user_tasks, only: [:update]
  end
end
