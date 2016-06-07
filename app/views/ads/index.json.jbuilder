json.array!(@ads) do |ad|
  json.extract! ad, :id, :district_id, :type_parking_id, :user_id, :period_id, :content
  json.url ad_url(ad, format: :json)
end
