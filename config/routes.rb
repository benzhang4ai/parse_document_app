Rails.application.routes.draw do
  resources :documents, only: [:index, :create, :show, :destroy] do
    get 'parse', on: :member
  end

  root "documents#index"
end
