class Event < ActiveRecord::Base

	validates :title, :event_date, :begti, {presence: true}

	validate :endti, if: :event_has_length




	def event_has_length
	#blank checkbox = false
		if self.has_length
			puts "checkbox marked"
			validates_time :endti, after: :begti, after_message: "must be after start time"
		else
			puts "checkbox blank"
			true
		end
	end





	def after_error_message
		return "End time must be after start time"
	end


#validates_time :endti, after: :begti, after_message: "must be after start time"
    #after_error_message

  end
