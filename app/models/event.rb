class Event < ActiveRecord::Base

validates :title, :event_date,
#:day_name,


#:begti, :endti,  #UNCOMMENT THIS !!
{presence: true}
    
    #has_length?
end
