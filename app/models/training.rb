class Training < ApplicationRecord
  has_many :timecells, as: :bookable

  validates_presence_of :name, :trainer, :price

  private
end
