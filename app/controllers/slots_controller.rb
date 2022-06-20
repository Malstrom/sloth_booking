# frozen_string_literal: true

class SlotsController < ApplicationController
  before_action :set_slot, only: %i[show edit update destroy]
  before_action :set_club, :selected_day, :set_starts_at_and_ends_at, only: %i[index set_working_time]

  # GET /slots or /slots.json
  def index
    @slots = Slot.all
  end

  # GET /slots/1 or /slots/1.json
  def show; end

  # GET /slots/new
  def new
    @slot = Slot.new
  end

  # GET /slots/1/edit
  def edit; end

  # POST /slots or /slots.json
  def create
    @slot = Slot.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to slot_url(@slot), notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

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

  # DELETE /slots/1 or /slots/1.json
  def destroy
    @slot.destroy

    respond_to do |format|
      format.html { redirect_to slots_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_starts_at_and_ends_at
    @starts_at = Time.parse(params[:starts_at])
    @ends_at = Time.parse(params[:ends_at])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    # @club = Price.find(params[:club_id])
    @club = Club.first
  end

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_day] ? params[:selected_day].to_date : Date.today
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
