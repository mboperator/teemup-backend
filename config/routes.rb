require 'api_constraints'

Teemup::Application.routes.draw do
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
