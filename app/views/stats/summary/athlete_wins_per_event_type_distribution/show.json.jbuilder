json.array! @event_types do |type|
  json.group Event.kinds.key(type).capitalize
  @wins[type].each do |row|
    json.set! row.athlete.name, row.wins
  end
end
