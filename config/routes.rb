PostitTemplate::Application.routes.draw do
  root to: 'prospects#index'

  resources :prospects
end
