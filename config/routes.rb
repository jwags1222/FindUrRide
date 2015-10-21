PostitTemplate::Application.routes.draw do
  Bitly.configure do |config|
    config.api_version = 3
    config.login = "esastincy"
    config.api_key = "R_345ec7ef692a4c31b3b8712bdb511561"
  end

  root to: 'prospects#index'

  resources :prospects

  post 'twilio/voice', to: 'twilio#voice'
  post 'twilio/text', to: 'twilio#text'
end
