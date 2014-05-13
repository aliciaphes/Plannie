Planner::Application.routes.draw do

	devise_for :users

	#root to: "devise/sessions#new", as: "user_root"

	devise_scope :user do
		authenticated :user do
			root 'events#index', as: :authenticated_root
		end

		unauthenticated do
			root 'devise/sessions#new', as: :unauthenticated_root
		end
	end


	#resources :events
	resources :users

	#get '/events/:id/gcreate', to: 'events#gcreate', as: "gevent"

	#get '/events/search/', to: 'events#search', as: "search"

	resources :events do
	  collection do
	    get :search
	    get :show_private
	    get :show_deleted
	    #get :restore
	  end
	end

	get '/events/:id/restore', to: 'events#restore', as: "restore"

end
