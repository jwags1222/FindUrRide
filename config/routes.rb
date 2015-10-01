PostitTemplate::Application.routes.draw do
  root to: 'prospects#index'

  resources :prospects

  post 'twilio/voice', to: 'twilio#voice'
  post 'twilio/text', to: 'twilio#text'
end
