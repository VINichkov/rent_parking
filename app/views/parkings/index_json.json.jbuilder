json.array!(@parkings) do |parking|
  json.extract! parking, :lat, :lng, :title
end
