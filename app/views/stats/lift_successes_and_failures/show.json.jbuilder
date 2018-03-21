json.array! @movements do |movement|
  json.group movement.name
  3.times do |attempt|
    json.set! "Attempt #{attempt + 1} Success", @success_and_failures[[movement.id, attempt, true]]
    json.set! "Attempt #{attempt+ 1} Failure", @success_and_failures[[movement.id, attempt, false]]
  end

end
