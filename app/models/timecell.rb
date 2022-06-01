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
    if (1..300) === price and bookable_type.nil?
      "cell-color-yellow"
    elsif (301..450) === price and bookable_type.nil?
      "cell-color-blue"
    elsif (451..600) === price and bookable_type.nil?
      "cell-color-green"
    elsif (601..750) === price and bookable_type.nil?
      "cell-color-pink"
    elsif (751..3000) === price and bookable_type.nil?
      "cell-color-purple"
    elsif bookable_type == "Training"
      "cell-color-training"
    elsif bookable_type == "Tournament"
      "cell-color-tournament"
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
