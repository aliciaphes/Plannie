class Event < ActiveRecord::Base

	validates :title, :event_date, :begti, {presence: true}
	#validates :begti, presence: {message: "Begin time can't be blank"}

	validate :endti, if: :event_has_length
	#validate end time only makes sense if the event has a specific length


	def event_has_length
	#blank checkbox = false

		puts "begti = '#{begti}'"

		if !begti.nil?
			puts "not empty"
		else puts "empty"
		end

		if self.has_length 
			#puts "validating #{endti} to see if it goes after #{begti}"
			puts "validating #{endti}"

			#if !begti.nil?
				validates_time :endti, after: :begti, after_message: "must be after start time"
			#else
				#false	
			#end

		else
			true
		end
	end




	def after_error_message
		return "End time must be after start time"
	end


end
