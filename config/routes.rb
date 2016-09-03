Rails.application.routes.draw do
		
	root "projects#index"	
	
	devise_for :users, controllers: { sessions: 'my_devise/sessions', registrations: 'my_devise/registrations', omniauth_callbacks: 'my_devise/omniauth_callbacks', passwords: 'my_devise/passwords', unlocks: 'my_devise/unlocks' }
	
	resources :projects do
		member do 
			get "add_developers" => "projects#add_developers_page"
			post "add_developers" => "projects#add_developers"
		end
		resources :todo_tasks do
			member do 
				get "assign_developers" => "todo_tasks#assign_developers_page"
				post "assign_developers" => "todo_tasks#assign_developers"
				
				post "set_task_status" => "todo_tasks#set_task_status"
			end
		end
	end
	
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
