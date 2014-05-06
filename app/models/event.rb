class Event < ActiveRecord::Base

	validates :title, :event_date, :begti, :endti,
#:day_name,
{presence: true}

    #has_length?


    def after_error_message
    	return "End time must be after start time"
    end


    validates_time :endti, after: :begti,
    after_message: "must be after start time"
    #after_error_message

end
