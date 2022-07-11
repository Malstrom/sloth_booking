# frozen_string_literal: true

class ClubsController < ApplicationController
  before_action :set_club, only: %i[show edit update destroy]

  # GET /clubs or /clubs.json
  def index
    @clubs = Club.where(nil)
    @duration = params[:duration] if params[:duration]
    @selected_day = params[:selected_day].to_date if params[:selected_day]
  end

  # GET /clubs/1 or /clubs/1.json
  def show
    @duration = params[:duration] if params[:duration]
    @selected_day = params[:selected_day].to_date if params[:selected_day]
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit; end

  # PATCH/PUT /clubs/1 or /clubs/1.json
  def update
    if @club.update(club_params)
      redirect_to root_path(selected_day: @selected_day), notice: 'Club was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.first
  end

  # Only allow a list of trusted parameters through.
  def club_params
    params.permit(:starts_at, :ends_at)
  end
end
