Planner::Application.routes.draw do

	devise_for :users

	#root to: "devise/sessions#new", as: "user_root"

	devise_scope :user do
		authenticated :user do
    root 'planner#index', as: :authenticated_root
  end

  unauthenticated do
  	root 'devise/sessions#new', as: :unauthenticated_root
  end
end






resources :events

end
