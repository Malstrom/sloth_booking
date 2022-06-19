class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def duration_in_minutes(duration)
    duration.to_i.hours.to_i / 60
  end
end
