require 'api_constraints'

Teemup::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:create, :show]
      resources :groups do
      	resources :events
      end
    end
  end
end