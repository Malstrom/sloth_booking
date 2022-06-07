class Training < ApplicationRecord
  belongs_to :club
  has_many :slots, as: :bookable

  validates_presence_of :name, :trainer, :price

  before_destroy :booked?, prepend: true

  private

  def booked?
    unless slots.empty?
      errors.add(:booked, "Can't delete tournament assigned to a slot")
      throw :abort
    end
  end
end
