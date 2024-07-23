Rails.application.routes.draw do
  resources :contact_messages
  root 'hello#index'
  get 'hello/about'
  get 'hello/contact'
  get 'contact_messages/new'
end
