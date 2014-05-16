class Event < ActiveRecord::Base

	validates :title, :event_date, :begti, {presence: true}

	validate :endti, if: :event_has_length
	#validate end time only makes sense if the event has a specific length



	def event_has_length
	#blank checkbox = false

	#puts "validating #{endti} to see if it goes after #{begti}"

		if self.has_length
			validates_time :endti, after: :begti, after_message: "must be after start time"
		else
			true
		end
	end




	def after_error_message
		return "End time must be after start time"
	end


end
