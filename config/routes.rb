Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get 'main' => 'main#main'
  get 'm_main' => 'mobile#m_main'
  get 'main/registration' => 'main#main_registration'
  get 'main/recovery-password' => 'main#main_recovery_password'
  get 'favorites' => 'main#favorites'
  get 'search' => 'main#search'
  # get 'live_chat' => 'main#live_chat'
  get 'live_chat' => 'main#live_chat2'
  get 'm_live_chat' => 'main#m_live_chat'
  get 'gifts' => 'main#gifts'

  get 'mail_box' => 'main#mail_box'
  get 'inbox' => 'main#inbox'


  get 'second-version' => 'main#second'

  get 'profile_girl' => 'main#profile_woman'
  get 'profile' => 'main#profile'
  get 'information' => 'main#information'
  get 'tripadvisor' => 'main#tripadvisor'
  get "settings", to: "main#settings"

  get 'mails' => 'main#mail_templates'

  get 'test' => 'main#test'
  get 'tt' => 'main#tt'

  post '/get-email-template' => 'main#email_template'

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
