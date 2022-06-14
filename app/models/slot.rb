# frozen_string_literal: true
class Slot < ApplicationRecord
  belongs_to :gametable
  belongs_to :bookable, polymorphic: true, optional: true

  attr_accessor :color

  enum :state, %i[open close]

  before_update :toggle_bookable

  validates :time, comparison: { greater_than: Time.now }, on: :update

  INTERVAL = 30.minutes

  scope :by_club, ->(club) { joins(:gametable).where('gametables.club_id = ?', club).order(:gametable_id, :time) }
  scope :open_slot, -> { where(state: :open) }
  scope :close_slot, -> { where(state: :close) }

  scope :by_day, ->(selected_day) { where(time: selected_day.beginning_of_day..selected_day.end_of_day) }
  scope :group_by_hours, -> { group_by { |cell| cell['time'].itself.localtime } }

  scope :group_by_day_hours, lambda { |selected_day|
    where(time: selected_day.beginning_of_day..selected_day.end_of_day)
      .group_by { |cell| cell['time'].itself.localtime }
  }

  scope :only_available, ->(not_available_times) { where.not(time: not_available_times) }

  scope :not_booked, -> { where(bookable_id: nil) }
  scope :booked, -> { where.not(bookable_id: nil) }

  def display_value
    case bookable_type
    when 'Training' then bookable.trainer
    when 'Tournament' then "< #{bookable.rating}"
    when 'Event' then bookable.email
    else
      price
    end
  end

  def define_color
    if bookable_type.nil?
      define_color_by_price
    else
      define_color_by_bookable
    end
  end

  def define_color_by_price
    case price.to_i
    when 0..300    then 'cell-color-yellow'
    when 301..450  then 'cell-color-blue'
    when 451..600  then 'cell-color-green'
    when 601..750  then 'cell-color-pink'
    when 751..3000 then 'cell-color-purple'
    else 'cell-color-yellow'
    end
  end

  def define_color_by_bookable
    case bookable_type
    when 'Training'    then 'cell-color-training'
    when 'Tournament'  then 'cell-color-tournament'
    when 'Event'       then 'cell-color-training'
    else 'cell-color-yellow'
    end
  end

  def self.update_working_date(club, selected_day, starts_at, ends_at)
    slots_to_close = Slot.by_club(club).by_day(selected_day).where('time < ? OR time >= ?', starts_at,
                                                                   ends_at).open_slot
    slots_to_open = Slot.by_club(club).by_day(selected_day).where(time: starts_at...ends_at).close_slot
    if slots_to_close.none?(&:bookable_id?)
      slots_to_close.update_all(state: :close)
      slots_to_open.update_all(state: :open)
    else
      false
    end
  end

  def remove_bookable
    update(bookable_type: nil, bookable_id: nil)
  end

  def self.available_slots(club, selected_day, duration)
    selected_day ||= Date.tomorrow
    duration     ||= 1

    duration_in_minutes = duration.to_i.hours.to_i / 60
    slots = Slot.by_club(club).by_day(selected_day)

    open_slots = slots.open_slot

    generate_slots(selected_day, club.id) if slots.empty?
    open_slots.only_available(unavailable_times(open_slots, duration_in_minutes))
  end

  def self.unavailable_times(open_slots, duration_in_minutes)
    closing_time = open_slots.group_by_hours.keys.last + INTERVAL
    booked_slots = open_slots.booked.group_by_hours

    booked_time_range = booked_slots.map { |time| time.first if time.last.count >= time.last.first.gametable.club.gametables.count }.compact

    times_not_bookable(booked_time_range, closing_time, duration_in_minutes)
  end

  def self.times_not_bookable(booked_times, closing_time, duration_in_minutes)
    not_available_times = []
    booked_times.append(closing_time).each do |time|
      start = time - duration_in_minutes.minutes
      start += INTERVAL if duration_in_minutes.minutes > INTERVAL
      (start.to_i..time.to_i).step(INTERVAL).map { |t| not_available_times << Time.at(t) }
    end
    not_available_times
  end

  def self.generate_slots(selected_day, club_id)
    club = Club.find club_id
    hours = time_interval_in_day(selected_day)

    club.gametables.each do |gametable|
      hours.each do |hour|
        if hour.strftime('%H:%M') < club.starts_at.strftime('%H:%M') || hour.strftime('%H:%M').to_s >= club.ends_at.strftime('%H:%M')
          gametable.slots.build(time: hour, price: 400).close!
        else
          gametable.slots.build(time: hour, price: 400).open!
        end
      end
    end
  end

  def self.time_interval_in_day(selected_day)
    (selected_day.beginning_of_day.to_i..selected_day.end_of_day.to_i).step(INTERVAL).map { |hour| Time.at(hour) }
  end

  private

  def toggle_bookable
    assign_attributes(bookable_type: nil, bookable_id: nil) unless changed?
  end
end
