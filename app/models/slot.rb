class Slot < ApplicationRecord
  belongs_to :gametable
  belongs_to :bookable, polymorphic: true, optional: true

  attr_accessor :color
  enum :state, [ :open, :close ]

  validate :already_booked, on: :update

  # validates_comparison_of :time, greater_than: -> { Date.today }

  scope :by_club, -> (club) { joins(:gametable).where("gametables.club_id = ?", club).order(:gametable_id, :time) }
  scope :open_slot, -> { where(state: :open) }
  scope :_group_by_day_hours, -> (selected_day) {
    where(time: selected_day.beginning_of_day..selected_day.end_of_day)
        .group_by{ |cell| cell['time'].itself.localtime }
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
    if bookable_type.nil?
      case price.to_i
      when 0..300
        "cell-color-yellow"
      when 301..450
        "cell-color-blue"
      when 451..600
        "cell-color-green"
      when 601..750
        "cell-color-pink"
      when 751..3000
        "cell-color-purple"
      else
        "cell-color-yellow"
      end
    else
      bookable_type == "Training" ? "cell-color-training" : "cell-color-tournament"
    end
  end

  def self.generate_slots(selected_day, club_id)
    club = Club.find club_id

    club_start = DateTime.parse(club.starts_at)
    club_end = DateTime.parse(club.ends_at)

    starts = selected_day.beginning_of_day
    ends = selected_day.end_of_day

    hours = (starts.to_i..ends.to_i).step(1.hour).map do |hour|
      Time.at(hour)
    end

    club.gametables.each do |gametable|
      hours.each do |hour|
        if hour.strftime("%H:%M") < club_start.strftime("%H:%M") or hour.strftime("%H:%M").to_s >= club_end.strftime("%H:%M")
          next if hour.strftime("%H:%M").to_s == "05:00"
        else
          Slot.create gametable: gametable, time: hour, price: 400
        end
      end
    end
  end

  private

  def already_booked
    if state.changed?
      unless bookable_type.nil?
        errors.add(:self_join, I18n.t('activerecord.errors.models.slot.already_booked_not_closable'))
      end
    end
  end
end
