# frozen_string_literal: true

class TrainingsController < ApplicationController
  before_action :set_club, :selected_day
  before_action :set_training, only: %i[update destroy]

  # POST /trainings or /trainings.json
  def create
    @training = @club.trainings.build(training_params)
    if @training.save
      bookable = { bookable_id: @training.id, bookable_type: 'Training' }.to_json
      redirect_to root_path(selected_day: @selected_day, params_to_send: bookable)
    else
      render json: @training.errors, status: :unprocessable_entity
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
