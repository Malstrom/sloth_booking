module TimetableHelper
  def define_day_color(selected_day, day)
    if day == selected_day
      "link-success fw-bold link-date"
    elsif day.on_weekend?
      "text-danger link-date"
    else
      "link-secondary link-date"
    end
  end
end
