Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post '/sign_in', to: 'auth#sign_in'
    post '/me', to: 'auth#me'
    post '/login', to: 'auth#login'
    post '/sup', to: 'auth#sup'
  end
