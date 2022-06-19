class Gametable < ApplicationRecord
  belongs_to :club
  has_many :slots, dependent: :delete_all

  # after_create :default_prices

  # def default_prices
  #   first_gametable_prices = self.club.gametables.first.prices
  #   first_gametable_prices.each do |price|
  #     price = self.prices.build(hour: price.hour, value:price.value)
  #     price.save
  #   end
  # end
  #
end
