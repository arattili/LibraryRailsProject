class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :userid
      t.integer :roomid
      t.datetime :time_date

      t.timestamps
    end
  end
end
