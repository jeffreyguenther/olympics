json.array! @events.to_a do |entry|
  json.name entry.first.capitalize
  json.count entry.second
end
