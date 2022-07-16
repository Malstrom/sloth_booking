# frozen_string_literal: true

class TimetableController < ApplicationController
  # before_action :authenticate_user!

  before_action :set_club, :selected_day

  def index
    @days = @selected_day.at_beginning_of_week..@selected_day.at_end_of_week

    @gametables = Gametable.where(club: @club)
    @slots_by_day_hours = Slot.by_club(@club).open_slot.by_day(@selected_day).group_by_hours
    @trainings = @club.trainings.by_selected_day(@selected_day)
    @tournaments = @club.tournaments.by_selected_day(@selected_day)
    @events = @club.events.by_selected_day(@selected_day)

    generate_slots if @slots_by_day_hours.empty?
  end

  def new_working_time
    @slots_by_day_hours = Slot.by_club(@club).open_slot.by_day(@selected_day).group_by_hours
  end

  private

  def generate_slots
    Slot.generate_slots(@selected_day, @club.id)
    @slots_by_day_hours = Slot.by_club(@club).open_slot.by_day(@selected_day).group_by_hours
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.first
  end

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_day] ? params[:selected_day].to_date : Time.zone.today
  end
end
