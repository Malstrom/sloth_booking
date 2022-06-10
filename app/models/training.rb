class Training < ApplicationRecord
  belongs_to :club
  has_many :slots, as: :bookable

  validates_presence_of :name, :trainer, :price, :day

  before_destroy :destroy_bookable, prepend: true

  scope :by_selected_day, ->(selected_day) { where(day: selected_day) }

  private

  def destroy_bookable
    slots.each(&:remove_bookable)
  end
end
