class Training < ApplicationRecord
  belongs_to :club
  has_many :slots, as: :bookable

  validates_presence_of :name, :trainer, :price

end
