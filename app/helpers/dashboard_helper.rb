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
end
