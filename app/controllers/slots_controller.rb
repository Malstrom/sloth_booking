# frozen_string_literal: true

class SlotsController < ApplicationController
  before_action :set_slot, only: %i[update]
  before_action :set_club, :selected_day, :set_starts_at_and_ends_at, only: %i[index set_working_time]

  # PATCH/PUT /slots/1 or /slots/1.json
  def update
    if @slot.update(slot_params)
      render json: @slot.attributes.merge({ color: @slot.define_color, display_value: @slot.display_value })
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  def set_working_time
    if @starts_at.to_date >= Date.today
      if Slot.update_working_date(@club, @selected_day, @starts_at, @ends_at)
        redirect_to timetable_index_path(selected_day: @selected_day), notice: 'Working time day updated'
      else
        redirect_to timetable_index_path(selected_day: @selected_day), alert: 'In this range there is a booked slot'
      end
    else
      redirect_to timetable_index_path(selected_day: @selected_day), alert: "You can't update in past or today"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_starts_at_and_ends_at
    @starts_at = Time.zone.parse(params[:starts_at])
    @ends_at = Time.zone.parse(params[:ends_at])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    # @club = Price.find(params[:club_id])
    @club = Club.first
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_slot
    @slot = Slot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def slot_params
    params.require(:slot).permit(:gametable_id, :time, :price, :bookable_id, :bookable_type)
  end
end
