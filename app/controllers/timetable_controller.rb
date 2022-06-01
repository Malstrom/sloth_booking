class TimetableController < ApplicationController
  before_action :set_club, :selected_day

  def index
    @days = @selected_day.at_beginning_of_week..(@selected_day.at_end_of_week)

    @gametables = Gametable.where(club: @club)
    @timecells = Timecell.group_prices_by_hours(@club, @selected_day)
    if @timecells.empty?
      Timecell.generate_prices(@selected_day, @club.id)
      @timecells = Timecell.group_prices_by_hours(@club, @selected_day)
    end

    @tournament = Tournament.new
    @training = Training.new
  end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_club
      # @club = Price.find(params[:club_id])
      @club = Club.first
    end

    # Use callbacks to share common setup or constraints between actions.
    def selected_day
      @selected_day = params[:selected_day] ? params[:selected_day].to_date : Date.today
    end
end
