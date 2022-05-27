class AddTournamentRatingToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :tournament_rating, :integer
  end
end
