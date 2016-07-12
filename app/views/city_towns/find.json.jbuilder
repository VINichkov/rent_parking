json.array!(@city_list) do |city_town|
  json.extract! city_town, :id, :name, :area_id
  json.url city_town_url(city_town, format: :json)
end