# frozen_string_literal: true

Rails.application.routes.draw do
  resources "rooms", only: %i[show create destroy]
  root "rooms#index"
  devise_for :users, skip: :session
  devise_scope :user do
    get "login" => "devise/sessions#new", as: :new_user_session
    post "login" => "devise/sessions#create", as: :user_session
    delete "logout" => "devise/sessions#destroy", as: :destroy_user_session
  end

  mount ActionCable.server => "/cable"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
