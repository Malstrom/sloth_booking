class Booking < ApplicationRecord
  belongs_to :price

  enum kind: [:fun, :group_training, :tournament]

end
