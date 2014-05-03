class EventsController < ApplicationController

	before_action :authenticate_user!

	def index
		#@events = Event.all
		@events = Event.where(email: current_user.email).order(:day_name)
	end


#def show
#end

	def new
		@event = Event.new
	end

end
