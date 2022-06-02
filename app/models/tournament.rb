class Tournament < ApplicationRecord
  has_many :timecells, as: :bookable

  validates_presence_of :name, :rating, :price
end
