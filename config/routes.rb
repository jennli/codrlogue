Rails.application.routes.draw do

  get '/home' => 'home#landing', as: :landing

  resources :employments do
    get :autocomplete_employment_company_name, :on => :collection
  end
  resources :companies
  resources :projects
  resources :categories
  resources :educations do
    get :autocomplete_education_school_name, :on => :collection
  end
  resources :skills
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users

  get "users/:id/contact" => "emails#show", as: :user_contact
  post "users/:id/contact" => "emails#send_email", as: :user_contact_send

  # Delay_job_web
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  get 'users/admin/:admin_random_string' => 'users#index', as: :admin
  get 'users/admin/:admin_random_string/admin_filter/:admin' => 'users#index', as: :admin_filter
  get 'users/filter/:filter_string' => 'users#index', as: :user_filter

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
  end

  resources :messages, only: [:new, :create]
  get "users/:id/password" => "users#edit_password", as: :user_password
  patch "users/:id/password" => "users#update_password"
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end


  resources :users_shortlists, only: [:create, :index] do
    delete :destroy, on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#landing'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
