Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :hotels
    end  
  end  

  namespace :admin do 
    

    resources :hotels do
      resources :rooms
    end
  end

  devise_for :admin_users
  devise_for :users
  root to: 'welcome#index'

  mount Sidekiq::Web, at: '/sidekiq'

  resources :hotels do
    resources :rooms
  end  


  resources :sites
  resources :posts do
    put :approve, on: :member
    put :decline, on: :member

    get :approved, on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end
