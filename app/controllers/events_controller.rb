class EventsController < ApplicationController
  before_action :set_club, :selected_day
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = @club.events.build(event_params)
    respond_to do |format|
      if @event.save
        bookable = { bookable_id: @event.id, bookable_type: "Event"}.to_json
        format.html { redirect_to root_path(selected_day:@selected_day, params_to_send: bookable)}
        format.json { render json: @event }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to root_path(selected_day:@selected_day), notice: "Event updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    if @event.destroy
      redirect_to timetable_index_path(selected_day: @selected_day), notice: "Event deleted"
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

    # Use callbacks to share common setup or constraints between actions.
  def selected_ay
    @selected_day = params[:selected_ay]
  end

    # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:club_id, :name, :email, :phone, :tables, :day, :price)
  end
end
