# frozen_string_literal: true

class TrainingsController < ApplicationController
  before_action :set_club, :selected_day
  before_action :set_training, only: %i[show edit update destroy]

  # GET /trainings or /trainings.json
  def index
    @trainings = Training.all
  end

  # GET /trainings/1 or /trainings/1.json
  def show; end

  # GET /trainings/new
  def new
    @training = Training.new
  end

  # GET /trainings/1/edit
  def edit; end

  # POST /trainings or /trainings.json
  def create
    @training = @club.trainings.build(training_params)
    respond_to do |format|
      if @training.save
        value = { bookable_id: @training.id, bookable_type: 'Training' }.to_json
        format.html do
          redirect_to root_path(selected_day: @selected_day),
                      notice: "Training saved! #{view_context.button_tag('Set in calendar', class: 'btn btn-primary btn-sm', value: value,
                                                                                            data: { controller: 'hello', action: 'click->hello#selectKind' })}"
        end
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1 or /trainings/1.json
  def update
    if @training.update(training_params)
      redirect_to timetable_index_path(selected_day: @selected_day), notice: 'Training updated'
    else
      redirect_to timetable_index_path(selected_day: @selected_day), alert: @training.errors
    end
  end

  # DELETE /trainings/1 or /trainings/1.json
  def destroy
    if @training.destroy
      redirect_to timetable_index_path(selected_day: @selected_day), notice: 'Training deleted'
    else
      redirect_to timetable_index_path(selected_day: @selected_day), alert: @training.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.find(params[:club_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_training
    @training = Training.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def selected_day
    @selected_day = params[:selected_day]
  end

  # Only allow a list of trusted parameters through.
  def training_params
    params.require(:training).permit(:trainer, :price, :day)
  end
end
