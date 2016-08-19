json.array!(@bookings) do |booking|
  json.extract! booking, :id, :datetimebegin, :datetimeend, :user_id, :parking_id
  json.url booking_url(booking, format: :json)
end
