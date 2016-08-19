json.array!(@parkings) do |parking|
  json.extract! parking, :id, :name, :adress, :latitude, :langitude, :accessible, :open24, :covered, :sitestaff, :overnight, :valet, :restrictions, :descriptions, :price, :typerent, :user_id
  json.url parking_url(parking, format: :json)
end
