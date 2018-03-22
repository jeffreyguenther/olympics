json.array! @athletes do |athlete|
  attempts = athlete.attempts.includes(:event)
    .where(movement: @movement)
    .order(:event_id)
    .limit(100)

  json.id athlete.name
  json.values attempts do |attempt|
    json.id attempt.event.id
    json.result attempt.result
  end
end
