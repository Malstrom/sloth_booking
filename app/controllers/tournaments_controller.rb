# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :set_club, :selected_day
  before_action :set_tournament, only: %i[update destroy]

  # POST /tournaments or /tournaments.json
  def create
    @tournament = @club.tournaments.build(tournament_params)
    bookable = { bookable_id: @tournament.id, bookable_type: 'Tournament' }.to_json
    if @tournament.save
      redirect_to root_path(selected_day: @selected_day, params_to_send: bookable)
    else
      redirect_to root_path(selected_day: @selected_day), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tournaments/1 or /tournaments/1.json
  def update
    if @tournament.update(tournament_params)
      redirect_to timetable_index_path(selected_day: @selected_day), notice: 'Tournament updated'
    else
      redirect_to timetable_index_path(selected_day: @selected_day), alert: @tournament.errors
    end
  end

  # DELETE /tournaments/1 or /tournaments/1.json
  def destroy
    if @tournament.destroy
      redirect_to timetable_index_path(selected_day: @selected_day), notice: 'Tournament deleted'
    else
      redirect_to timetable_index_path(selected_day: @selected_day), alert: @tournament.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.find(params[:club_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_ay]
  end

  # Only allow a list of trusted parameters through.
  def tournament_params
    params.require(:tournament).permit(:rating, :price, :day)
  end
end
