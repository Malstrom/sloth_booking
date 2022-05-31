class Timecell < ApplicationRecord
  belongs_to :gametable

  belongs_to :bookable, polymorphic: true, optional: true

  attr_accessor :color

  scope :group_prices_by_hours, -> (club, selected_day) {
    joins(:gametable)
        .where("gametables.club_id = ?", club)
        .where(time: selected_day.beginning_of_day..selected_day.end_of_day)
        .order(:gametable_id, :time)
        .group_by{ |cell| cell['time'].itself }
  }

  def display_value
    if bookable_type == "Training"
      bookable.trainer
    elsif bookable_type == "Tournament"
      bookable.rating
    else
      price
    end
  end

  def define_color
    case price.to_i
    when 0..400
      "success"
    when 401..500
      "warning"
    when 501..1000
      "danger"
    else
      "secondary"
    end
  end

  def self.generate_prices(selected_day, club_id)
    starts = selected_day.beginning_of_day + 7.hours
    ends = selected_day.beginning_of_day + 23.hours
    hours = (starts.to_i..ends.to_i).step(1.hour).map do |hour|
      Time.at(hour)
    end

    club = Club.find club_id

    club.gametables.each do |gametable|
      hours.each do |hour|
        case hour.strftime("%H").to_i
        when 0..12
          Timecell.create gametable: gametable, time: hour, price: 400
        when 13..16
          Timecell.create gametable: gametable, time: hour, price: 500
        when 17..24
          Timecell.create gametable: gametable, time: hour, price: 600
        else
          Timecell.create gametable: gametable, time: hour, price: 100
        end
        p hour
      end
    end
  end
end
