json.array! @wins.to_a do |entry|
  json.name entry.first.name
  json.count entry.second
end
