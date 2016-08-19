json.array!(@roles) do |role|
  json.extract! role, :id, :code, :name, :descriptions
  json.url role_url(role, format: :json)
end
