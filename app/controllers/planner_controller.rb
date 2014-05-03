class PlannerController < ApplicationController

	def index
		#@events = Event.all
		@events = Event.where(email: current_user.email).order(:day_name)
	end

end
