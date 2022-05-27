class Price < ApplicationRecord
  belongs_to :gametable
  has_many   :bookings, dependent: :delete_all
  has_many   :users, through: :bookings

  after_update_commit { broadcast_replace_to "prices" }

  attr_accessor :color

  # scope :group_prices_by_hours, -> (club) {
  #                                 joins(:gametable).where("gametables.club_id = ?", club)
  #                                               .order(:gametable_id, :hour).group_by{ |price| price['hour'].itself }
  # }

  scope :group_prices_by_hours, -> (club, selected_day) {
    joins(:gametable)
        .where("gametables.club_id = ?", club)
        .where(hour: selected_day.beginning_of_day..selected_day.end_of_day)
        .order(:gametable_id, :hour)
        .group_by{ |price| price['hour'].itself }
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
