json.array!(@patchphotos) do |patchphoto|
  json.extract! patchphoto, :id, :patch, :parking_id
  json.url patchphoto_url(patchphoto, format: :json)
end
