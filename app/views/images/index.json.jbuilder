json.array!(@images) do |image|
  json.extract! image, :id, :ad_id, :name, :path, :content
  json.url image_url(image, format: :json)
end
