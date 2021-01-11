Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post '/me', to: 'auth#me'
    post '/login', to: 'auth#login'
    post '/sup', to: 'auth#sup'
    post '/logout', to: 'auth#logout'
  end
