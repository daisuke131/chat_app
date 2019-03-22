Rails.application.routes.draw do
  resources 'rooms', only: [:show, :create, :destroy]
  root 'rooms#index'
  devise_for :users
  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
