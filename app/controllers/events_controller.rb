class EventsController < ApplicationController

	before_action :authenticate_user!

	def index
		#@events = Event.all
		@events = Event.where(email: current_user.email, deleted: false).order(:event_date)
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


	def gcreate
		@event = Event.find(params[:id])
		
		if @init.nil?
			@init = init_service
		end

		#retrieve all necessary info from event

g_event = {
			'summary' => @event.title,
			'description' => @event.comments,
			'start' => {
				'dateTime' => '2011-06-03T10:00:00.000-07:00'
				},
			'end' => {
					'dateTime' => '2011-06-03T10:25:00.000-07:00'
					}
		}
		result = @client.execute(:api_method => @service.events.insert,
			:parameters => {'calendarId' => 'primary'},
			:body => JSON.dump(g_event),
			:headers => {'Content-Type' => 'application/json'})		
	end




	private

	#Make sure the 'event' key is in the params hash: _require_ method

	#add stuff to the white list: _permit_ method
	def safe_params
		params.require(:event).permit(:title, :event_date, :begti, :endti, :comments, :has_length)
		#:day_name
	end


	def init_service
=begin
		oauth_yaml = YAML.load_file('.google-api.yaml')
		client = Google::APIClient.new
		client.authorization.client_id = oauth_yaml["client_id"]
		client.authorization.client_secret = oauth_yaml["client_secret"]
		client.authorization.scope = oauth_yaml["scope"]
		client.authorization.refresh_token = oauth_yaml["refresh_token"]
		client.authorization.access_token = oauth_yaml["access_token"]
=end

		@client = Google::APIClient.new
		@client.authorization.client_id = "889067249941.apps.googleusercontent.com"
		@client.authorization.client_secret = "0vCaXnf2L1PT-NLfYUw5f7bL"
		@client.authorization.scope = "https://www.googleapis.com/auth/calendar"
		@client.authorization.refresh_token = nil #oauth_yaml["refresh_token"]
		@client.authorization.access_token = nil #oauth_yaml["access_token"]

		if @client.authorization.refresh_token && @client.authorization.expired?
			@client.authorization.fetch_access_token!
		end

		@service = @client.discovered_api('calendar', 'v3')	
	end

end
