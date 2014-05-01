Planner::Application.routes.draw do

  devise_for :users
	root to: 'planner#index'
	#match '/index', to: 'planner#index', via: 'get'


	resources :events

end
