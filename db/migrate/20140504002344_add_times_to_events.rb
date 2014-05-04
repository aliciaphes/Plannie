class AddTimesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :begti, :time
  	add_column :events, :endti, :time
  	remove_column :events, :begda
  	remove_column :events, :endda
  end
end
