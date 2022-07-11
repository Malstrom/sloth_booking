# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_club, :selected_day
  before_action :set_event, only: %i[update destroy]

  def new
    @event = Event.new
  end

  # POST /events or /events.json
  def create
    @event = @club.events.build(event_params)
    if @event.save
      bookable = { bookable_id: @event.id, bookable_type: 'Event' }.to_json
      redirect_to root_path(selected_day: @selected_day, params_to_send: bookable)
    else
      redirect_to root_path(selected_day: @selected_day), notice: 'something wrong'
    end

  end

  def book
    @event = @club.events.build(event_params)
    if @event.save
      @event.reserve_slots
      redirect_to club_event_path(@club, @event), notice: 'Event created'
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
      if @event.update(event_params)
        redirect_to root_path(selected_day: @selected_day), notice: 'Event updated'
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    if @event.destroy
      redirect_to timetable_index_path(selected_day: @selected_day), notice: 'Event deleted'
    else
      redirect_to timetable_index_path(selected_day: @selected_day), alert: @event.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.find(params[:club_id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:club_id, :name, :email, :phone, :tables, :day, :starts_at, :duration)
  end
end
