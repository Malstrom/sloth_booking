module ApplicationHelper

  def prev_week(day = :monday)
    days_into_week = { :monday => 0, :tuesday => 1, :wednesday => 2, :thursday => 3, :friday => 4, :saturday => 5, :sunday => 6}
    result = (self - 7).beginning_of_week + days_into_week[day]
    self.acts_like?(:time) ? result.change(:hour => 0) : result
  end

  def selected_day_hours_for_select(day)

    hours = (day.to_time.to_i..day.to_time.at_end_of_day.to_i).step(1.hour).map do |hour|
      [(Time.at(hour)).strftime("%H:%M"), Time.at(hour)]
    end
    p hours
    hours.sort
  end
end
