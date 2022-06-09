class Slot < ApplicationRecord
  belongs_to :gametable
  belongs_to :bookable, polymorphic: true, optional: true

  attr_accessor :color

  enum :state, %i[open close]

  before_update :toggle_bookable

  validates :time, comparison: { greater_than: Time.now }, on: :update

  scope :by_club, ->(club) { joins(:gametable).where('gametables.club_id = ?', club).order(:gametable_id, :time) }
  scope :open_slot, -> { where(state: :open) }
  scope :by_day, ->(selected_day) {
    where(time: selected_day.beginning_of_day..selected_day.end_of_day)
  }
  scope :group_by_day_hours, ->(selected_day) {
    where(time: selected_day.beginning_of_day..selected_day.end_of_day)
      .group_by { |cell| cell['time'].itself.localtime }
  }

  def display_value
    case bookable_type
    when 'Training' then bookable.trainer
    when 'Tournament' then "< " + bookable.rating.to_s
    else
      price
    end
  end

  def define_color
    if bookable_type.nil?
      case price.to_i
      when 0..300    then 'cell-color-yellow'
      when 301..450  then 'cell-color-blue'
      when 451..600  then 'cell-color-green'
      when 601..750  then 'cell-color-pink'
      when 751..3000 then 'cell-color-purple'
      else 'cell-color-yellow'
      end
    else
      bookable_type == 'Training' ? 'cell-color-training' : 'cell-color-tournament'
    end
  end

  def self.generate_slots(selected_day, club_id)
    club = Club.find club_id
    club_start = DateTime.parse(club.starts_at)
    club_end = DateTime.parse(club.ends_at)
    starts = selected_day.beginning_of_day
    ends = selected_day.end_of_day

    hours = (starts.to_i..ends.to_i).step(1.hour).map { |hour| Time.at(hour) }

    club.gametables.each do |gametable|
      hours.each do |hour|
        if hour.strftime('%H:%M') < club_start.strftime('%H:%M') || hour.strftime('%H:%M').to_s >= club_end.strftime('%H:%M')
          gametable.slots.build(time: hour, price: 400).close!
        else
          gametable.slots.build(time: hour, price: 400).open!
        end
      end
    end
  end

  def self.update_working_date(club, selected_day, starts_at, ends_at)
    if starts_at.to_date >= Date.today
      slots_to_close = Slot.by_club(club).by_day(selected_day).where("time < ? OR time > ?", starts_at,
                                                                     ends_at).open_slot
      slots_to_open = Slot.by_club(club).by_day(selected_day).where(time: starts_at..ends_at)
      if !slots_to_close.any? { |slot| slot.bookable_id? }
        slots_to_close.update_all(state: :close)
        slots_to_open.where(state: :close).update_all(state: :open)
      else
        false
      end
    end
  end

  private

  def toggle_bookable
    assign_attributes(bookable_type: nil, bookable_id: nil) unless changed?
  end
end
