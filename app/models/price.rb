class Price < ApplicationRecord
  belongs_to :gametable
  has_many   :bookings, dependent: :delete_all
  has_many   :users, through: :bookings

  after_update_commit { broadcast_replace_to "prices" }

  attr_accessor :color

  scope :group_prices_by_hours, -> (club, selected_day) {
    joins(:gametable)
        .where("gametables.club_id = ?", club)
        .where(hour: selected_day.beginning_of_day..selected_day.end_of_day)
        .order(:gametable_id, :hour)
        .group_by{ |price| price['hour'].itself }
  }

  # .strftime("%H:%M")
  def define_color
    case value.to_i
    when 0..400
      "success"
    when 401..500
      "warning"
    when 501..700
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
          Price.create gametable: gametable, hour: hour, value: 400
        when 14..16
          Price.create gametable: gametable, hour: hour, value: 500
        when 19..24
          Price.create gametable: gametable, hour: hour, value: 700
        else
          Price.create gametable: gametable, hour: hour, value: 400
        end
        p hour
      end
    end
  end


end
