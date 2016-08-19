class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.datetime :datetimebegin
      t.datetime :datetimeend
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :parking, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
