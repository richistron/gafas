Rails.application.routes.draw do
  get '/sign_in', to: 'auth#sign_in'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
