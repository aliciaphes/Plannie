class EventsController < ApplicationController

	before_action :authenticate_user!

	def index
		#@events = Event.all
		@events = Event.where(email: current_user.email).order(:event_date)
		#.order(:day_name)

		if !@events.empty?
			@current_day = @events[0].event_date
		end
	end


	def show #show a particular event
		@event = Event.find(params[:id])
	end


	def new
		@event = Event.new
	end


	def create
		@event = Event.new(safe_params)

		@event.email  = current_user.email

		if @event.save
			redirect_to events_path
		else
			render :new
		end
	end



	def edit
		@event = Event.find(params[:id])
	end


	def update
		if params[:cancel]
			redirect_to @event
		else
			@event = Event.find(params[:id])

			if @event.update(safe_params)
				redirect_to @event
			else
				render :edit
			end				
		end

	end


	private

	#Make sure the 'event' key is in the params hash: _require_ method

	#add stuff to the white list: _permit_ method
	def safe_params
		params.require(:event).permit(:title, :event_date, :begti, :endti, :comments
		#:day_name
		)

		#has_length??
	end


end
