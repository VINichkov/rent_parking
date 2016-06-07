json.array!(@city_towns) do |city_town|
  json.extract! city_town, :id, :name, :area
  json.url city_town_url(city_town, format: :json)
end
