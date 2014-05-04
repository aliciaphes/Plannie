class AddEventDateToEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :date  	
  	add_column :events, :event_date, :date
  end
end
