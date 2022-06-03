class Training < ApplicationRecord
  has_many :slots, as: :bookable

  validates_presence_of :name, :trainer, :price

  private
end
