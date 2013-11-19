Physicsninja::Application.routes.draw do
  resources :users
  resources :sessions,    only: [:new, :create, :destroy]
  resources :questions do
    resources :responses, only: [:create, :index, :destroy]
    resources :comments,  only: [:create, :index, :destroy]
  end
  resources :plans,       only: :index
  resources :purchases,   only: [:show, :new, :create, :destroy]
  resources :ninjas,      only: [:new, :create]

  root to: 'static_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/buy',     to: 'plans#index'

  match '/support', to: 'static_pages#support'
  match '/about',   to: 'static_pages#about'
  match '/admin',   to: 'static_pages#admin'

  match '/pending',   to: 'questions#pending'
  match '/answered',  to: 'questions#answered'
  match '/commented', to: 'questions#commented'

  match 'users/:id/toggle_admin', to: 'users#toggle_admin'
  match 'users/:id/toggle_ninja', to: 'users#toggle_ninja'
  match 'users/:id/give_q',       to: 'users#give_q'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end