Rails.application.routes.draw do
  #get 'auth/auth'

  post '/api/v1/sfu/auth', to: 'auth#auth'
end
