class Rent < ApplicationRecord
  belongs_to :booking
  belongs_to :trainer
end
