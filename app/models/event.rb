# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :club
  has_many :slots, as: :bookable, dependent: :nullify

  before_validation :define_ends_at, if: :duration

  validates :phone, :name, presence: true

  validate :reserve_time, if: :starts_at

  before_destroy :destroy_bookable, prepend: true

  scope :by_selected_day, ->(selected_day) { where(day: selected_day) }

  def reserve_slots
    @available_to_reserve.where(gametable_id: @available_to_reserve.pluck(:gametable_id).uniq.sample).map do |slot|
      slot.update(bookable: self)
    end
  end

  private

  def define_ends_at
    self.ends_at = starts_at + duration_in_minutes(duration).minutes
  end

  def reserve_time
    @available_to_reserve = Slot.by_club(club).open_slot.not_booked.by_time_range(starts_at, ends_at)

    errors.add(:slots, 'are already booked') if @available_to_reserve.empty?
  end

  def update_reservation_time
    Slot.update_reservation_slots(stars_at, ends_at, slots)
  end

  def destroy_bookable
    slots.each(&:remove_bookable)
  end
end
