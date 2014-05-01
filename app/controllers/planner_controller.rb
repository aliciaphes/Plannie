class PlannerController < ApplicationController

def index
	@events = Event.all
end

end
