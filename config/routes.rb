Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    omniauth_callbacks: 'user/omniauth_callbacks'
  }
  resources :contact_messages do
    resources :comments, only: [:create]
    resources :contact_messages, only: [:create,:new,:show]
  end

  root 'hello#index'

  get 'hello/about'
  get 'hello/contact'
  get 'contact_messages/new'
end
