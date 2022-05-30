class Tournament < ApplicationRecord
  has_many :timecells, as: :bookable
end
