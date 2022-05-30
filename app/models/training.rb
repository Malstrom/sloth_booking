class Training < ApplicationRecord
  has_many :timecells, as: :bookable
end
