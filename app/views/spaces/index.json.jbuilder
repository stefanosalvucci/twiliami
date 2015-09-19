json.array!(@spaces) do |space|
  json.extract! space, :id, :phone
  json.url space_url(space, format: :json)
end
