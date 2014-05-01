class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.integer :day_name
      t.boolean :has_length
      t.date :begda
      t.date :endda
      t.text :comments

      t.timestamps
    end
  end
end
