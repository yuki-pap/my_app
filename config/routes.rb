Rails.application.routes.draw do



  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get  '/home', to:'static_pages#home'
  get  '/help', to:'static_pages#help'
  get  '/about', to:'static_pages#about'
  get  '/contact', to:'static_pages#contact'

  get '/signup', to:'users#new'

  get '/login', to:'sessions#new'

  post '/login', to:'sessions#create'

  delete '/logout', to:'sessions#destroy'

  get 'ranks/today'

  get 'ranks/week'

  get 'ranks/month'

  resources :analyses, only: [:index]
  get 'users/feed'
  resources :users



  resources :studies


  resources :account_activations, only: [:edit]

  resources :evaluates, only: [:update]

  resources :password_resets, only:[:new,:create,:edit,:update]

  resources :diaries

  resources :plans

  resources :markers, only: [:create, :new,:update, :edit]

  resources :relationships, only: [:create, :destroy]



  resources :users do
    member do
      get :following, :followers
    end
  end

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :graphs, only: [:index, :create]
      get 'graphs/color'
      resources :histories, only: [:index, :create]
      get 'charts/day'
      get 'charts/month'
      resources :tasks
      resources :time_by_field_todays, only: [:index]
      resources :time_by_fields, only: [:index]
      resources :feeds, only: [:index]
      resources :timers
    end
  end


end
