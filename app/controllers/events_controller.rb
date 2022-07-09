# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_club, :selected_day
  before_action :set_event, only: %i[update destroy]

  # POST /events or /events.json
  def create
    @event = @club.events.build(event_params)
    respond_to do |format|
      if @event.save
        bookable = { bookable_id: @event.id, bookable_type: 'Event' }.to_json
        format.html { redirect_to root_path(selected_day: @selected_day, params_to_send: bookable) }
        format.json { render json: @event }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def book
    @event = @club.events.build(event_params)
    if @event.save
      value = { bookable_id:@event.id, bookable_type:"Event" }.to_json
      redirect_to root_path(selected_day:@selected_day), notice: notice_with_button(value)
    else
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to root_path(selected_day: @selected_day), notice: 'Event updated' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
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

  def notice_with_button(value)
    "Tournament saved! #{view_context.button_tag('Set in calendar', class:'btn btn-primary btn-sm',value: value, data: {controller: "hello", action: "click->hello#selectKind"})}"
  end

    # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.find(params[:club_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_day]
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:club_id, :name, :email, :phone, :tables, :day, :starts_at, :duration )
  end
end
