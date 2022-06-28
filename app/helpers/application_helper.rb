# frozen_string_literal: true

module ApplicationHelper
  def prev_week(day = :monday)
    days_into_week = { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5,
                       sunday: 6 }
    result = (self - 7).beginning_of_week + days_into_week[day]
    acts_like?(:time) ? result.change(hour: 0) : result
  end

  def selected_day_hours_for_select(day)
    hours = (day.at_beginning_of_day.to_i..day.at_end_of_day.to_i).step(30.minutes).map do |hour|
      [(Time.at(hour).utc).strftime('%H:%M'), Time.at(hour).utc]
    end
    Rails.logger.debug hours
    hours.sort
  end

  def device
    agent = request.user_agent
    return 'tablet' if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return 'mobile' if agent =~ /Mobile/

    'desktop'
  end
end
