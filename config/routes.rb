# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :movies, only: [:index]
      resources :seasons, only: [:index]
      resources :contents, only: [:index]
      resources :purchases, only: %i[index create]
    end
  end
end
