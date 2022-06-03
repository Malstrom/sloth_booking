class Tournament < ApplicationRecord
  has_many :slots, as: :bookable

  validates_presence_of :name, :rating, :price
end
