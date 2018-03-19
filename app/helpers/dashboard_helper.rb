module DashboardHelper
  def movement_emoji(movement)
    if movement.run?
      "🏃🏻‍♂️"
    elsif movement.row?
      "🚣🏿‍♂️"
    else
      "🏋️‍♂️"
    end
  end

  def avatar_for(athlete)
    case athlete.name
    when "Sam Strong"
      "chris.jpg"
    when "Wally Wobbles"
      "albert.jpg"
    when "Junior Jumps"
      "hunter.jpg"
    when "Peter Power"
      "sankey.jpg"
    end
  end
end
