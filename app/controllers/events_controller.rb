class EventsController < ApplicationController

	before_action :authenticate_user!

	def index
		#@events = Event.all
		@events = Event.where(email: current_user.email, deleted: false, is_private: false).order(:event_date)

		if !@events.empty?
			@current_day = @events[0].event_date
		end
	end


	def show #show a particular event
		@event = Event.find(params[:id])


#<span><%= #link_to "Create Google Calendar event", gevent_path %></span>
#<span><%= link_to "Create Google Calendar event", "http://www.google.com/calendar", target: "_blank" %></span> -->

#dates	Of the form: START/END where START and END are in ISO8601 format
#%Y%m%dT%H%MZ
#&dates=20140127T224000Z/20140320T221500Z
		iso_date  = @event.event_date.strftime("%Y%m%d")
		iso_begti = @event.begti.strftime("%H%M%S")
		#iso_endti = iso_begti
		iso_endti = @event.endti.strftime("%H%M%S")

		@complete_date = "#{iso_date}T#{iso_begti}Z/#{iso_date}T#{iso_endti}Z"
	end


	def new
		@event = Event.new
	end


	def create
		@event = Event.new(safe_params)

		#if the event has no length, we set endtime=starttime before saving to avoid errors:
		@event.endti   = @event.begti

		@event.email   = current_user.email
		@event.deleted = false

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


	def destroy
		@event = Event.find(params[:id])
		@event.deleted = true
		if @event.save
			redirect_to events_path
		else
			#there was a problem deleting the record
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
