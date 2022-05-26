class Club < ApplicationRecord
  has_many   :gametables, dependent: :delete_all

end
