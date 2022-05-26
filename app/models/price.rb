class Price < ApplicationRecord
  belongs_to :gametable
  has_many   :bookings, dependent: :delete_all
  has_many   :users, through: :bookings

  attr_accessor :color

  scope :group_prices_by_hours, -> (club) { joins(:gametable).where("gametables.club_id = ?", club)
                                                .order(:gametable_id, :hour).group_by{ |price| price['hour'].itself }
  }


  # .strftime("%H:%M")
  def define_color
    case value.to_i
    when 0..400
      "success"
    when 401..500
      "warning"
    when 501..700
      "danger"
    else
      "secondary"
    end
  end

end
