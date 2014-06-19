class EventsController < ApplicationController

	before_action :authenticate_user!

	def index
		@events = Event.where(email: current_user.email, deleted: false, is_private: false).order(:event_date)

		if !@events.empty?
			@current_day = @events[0].event_date
			@to_display  = "I"
		end
	end


	def show #show a particular event
		@event = Event.find(params[:id])

		#The 'export' to Google calendar needs the date in the following format:
		#START/END where START and END are in ISO8601 format:
		#example = 20140127T224000Z/20140320T221500Z

		iso_date  = @event.event_date.strftime("%Y%m%d")

		iso_begti = @event.begti.strftime("%H%M%S")
		iso_endti = @event.endti.strftime("%H%M%S")

		@complete_date = "#{iso_date}T#{iso_begti}Z/#{iso_date}T#{iso_endti}Z"
	end


	def new
		@event = Event.new
	end


	def create
		if params[:commit] != "Create"
			redirect_to events_path
		else
			@event = Event.new(safe_params)

			@event.email   = current_user.email
			@event.deleted = false

			#if the event has no length, we set endtime=starttime before saving to avoid errors:
			if !params[:has_length]
				@event.endti   = @event.begti
			end

			if @event.save
				redirect_to events_path
			else
				render :new
			end
		end
	end



	def edit
		@event = Event.find(params[:id])
	end


	def update
		@event = Event.find(params[:id])

		if params[:commit] == "Cancel"
			redirect_to @event
		else
			if @event.update(safe_params)
				redirect_to @event
			else
				render :edit
			end				
		end

	end


	def destroy
		@event = Event.find(params[:id])
		@event.deleted = true
		if @event.save
			redirect_to events_path
		else
			#there was a problem deleting the record
		end
	end



	def search
		#This search method does not search for deleted events
		#It is also case sensitive

		@events = []

		if !params[:search_this].empty?

			#search events by title and comments (using OR)
			#The 'where' query returns an ActiveRecord::Relation
			@events = Event.where(["email = ? and deleted = ? and (title LIKE ? or comments LIKE ?)", "#{current_user.email}", false, "%#{params[:search_this]}%", "%#{params[:search_this]}%"]).order(:event_date)
			#@events = Event.where("email = :email AND deleted = :deleted AND title LIKE :pattern",{ email: "#{current_user.email}", deleted: false, pattern: "%#{params[:search_this]}%" })

			if !@events.empty?
				@current_day = @events[0].event_date
				@search_term = params[:search_this]
				@to_display  = "S"
			end
		end
		render "index"
	end


	def show_private
		@events = Event.where(email: current_user.email, deleted: false, is_private: true).order(:event_date)

		if !@events.empty?
			@current_day = @events[0].event_date
			@to_display  = "P"
		end
		render "index"
	end


	def show_deleted
		#this returns private and public events
		@events = Event.where(email: current_user.email, deleted: true).order(:event_date)

		if !@events.empty?
			@current_day = @events[0].event_date
			@to_display  = "D"
		end
		render "index"
	end



	def restore
		@event = Event.find(params[:id])

		@event.deleted = false

		if @event.save
			redirect_to show_deleted_events_path #go to deleted events
		else
			redirect_to event_path #display event
			#I should display error message as well
		end	
	end



#Private section

private

	#Make sure the 'event' key is in the params hash: _require_ method

	#add stuff to the white list: _permit_ method
	def safe_params
		params.require(:event).permit(:title, :event_date, :begti, :endti, :comments, :has_length, :is_private)
	end

end
