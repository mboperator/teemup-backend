require 'api_constraints'

Teemup::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:create, :show, :update]
      resources :groups, only: [:create, :index, :show, :update, :destroy] do
      	resources :events
      end
    end
  end
end
