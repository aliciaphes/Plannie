Planner::Application.routes.draw do

	root to: 'planner#index'
	#match '/index', to: 'planner#index', via: 'get'


	resources :events

end
