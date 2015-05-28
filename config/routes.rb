Rails.application.routes.draw do
  #get 'auth/auth'

  post '/api/v1/auth', to: 'auth#auth'
end
