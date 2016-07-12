Rails.application.routes.draw do
  #Роуты json
  get 'city_towns/:id/find' => 'city_towns#find', as: :find_city
  get 'areas/:id/set_area_session' =>'areas#set_area_session', as: :set_area_session
  get 'areas/get_area_session' => 'areas#get_area_session', as: :get_area_session

  devise_for :users
  resources :images
  resources :ads
  resources :users
  resources :roles
  resources :periods
  resources :districts
  resources :city_towns
  resources :areas
  resources :type_parkings
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'index#index'
  resources :properts

  #Роуты на документацию
  get 'info/socket'
  get 'info/convention'
  get 'info/offer'



  #роут для devise
  #root to: "home#index"

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
