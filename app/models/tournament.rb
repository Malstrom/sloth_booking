class Tournament < ApplicationRecord
  belongs_to :club
  has_many :slots, as: :bookable

  validates_presence_of :name, :rating, :price
end
