Rails.application.routes.draw do
  post '/sign_in', to: 'auth#sign_in'
  post '/me', to: 'auth#me'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
