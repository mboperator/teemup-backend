require 'api_constraints'

Teemup::Application.routes.draw do

  root 'sessions#new'
  match '/signup',   to: 'users#new',        via: 'get'
  match '/signin',   to: 'sessions#new',     via: 'get'
  match '/signout',  to: 'sessions#destroy', via: ['get', 'delete']

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :sessions, only: [:create]
      resources :users, only: [:create, :show, :update]
      resources :friendships, only: [:create, :index, :update, :destroy]
      resources :locations, only: [:index, :show, :create]
      resources :groups, only: [:create, :index, :show, :update, :destroy] do
      	resources :events, only: [:create, :index, :show, :update, :destroy]
      end
    end
  end
end
