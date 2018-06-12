Rails.application.routes.draw do

  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "application#home"
  post "/search", to: "application#search", as: "home_search"

  get '/users/add-user/:username', to: 'users#edit', as: "add_user"
  patch '/users/add-user/:username', to: 'users#update'
  get '/users/search-user', to: 'users#search', as: "find_user"
  post '/users/search-user', to: 'users#find'
  get '/users/add-technical-coach/:username', to: 'users#add_technical_coach', as: "add_technical_coach"
  post '/users/add-technical-coach/:username', to: 'users#set_technical_coach'
  # get '/tc/add-user/:username', to: 'users#edit', as: "add_user"

  ## AAQ ##
  get '/tcs/aaq', to: 'aaq#index', as: "aaq"
  post "/tcs/aaq/search", to: "aaq#search", as: "aaq_search"
  get '/tcs/aaq/:slug', to: 'aaq#show', as: "find_tc_aaq"

  ## Study Groups ##
  get '/tcs/study_group', to: 'study_group#index', as: "study_group"
  post "/tcs/study_group/search", to: "study_group#search", as: "study_group_search"
  get '/tcs/study_group/:slug', to: 'study_group#show', as: "find_tc_study_group"

  ## One On One Support ##
  get '/tcs/one_on_one', to: 'one_on_one#index', as: "one_on_one"
  post "/tcs/one_on_one/search", to: "one_on_one#search", as: "one_on_one_search"
  get '/tcs/one_on_one/:slug', to: 'one_on_one#show', as: "find_tc_one_on_one"
end
