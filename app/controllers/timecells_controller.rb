
class TimecellsController < ApplicationController
  before_action :set_timecell, only: %i[ show edit update destroy ]
  before_action :set_club, :selected_day, only: %i[ index ]

  # GET /timecells or /timecells.json
  def index
    @days = Date.today..(Date.today + 6.day)
    @gametables = Gametable.where(club: @club)
    @timecells = Timecell.group_prices_by_hours(@club, @selected_day)
    if @timecells.empty?
      Timecell.generate_prices(@selected_day, @club.id)
      @timecells = Timecell.group_prices_by_hours(@club, @selected_day)
    end
    #
    # @tournament = Tournament.new
    # @training = Training.new
  end

  # GET /timecells/1 or /timecells/1.json
  def show
  end

  # GET /timecells/new
  def new
    @timecell = Timecell.new
  end

  # GET /timecells/1/edit
  def edit
  end

  # POST /timecells or /timecells.json
  def create
    @timecell = Timecell.new(timecell_params)

    respond_with @timecell

    respond_to do |format|
      if @timecell.save
        format.html { redirect_to timecell_url(@timecell), notice: "Timecell was successfully created." }
        format.json { render json: @timecell }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @timecell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timecells/1 or /timecells/1.json
  def update
    if @timecell.update(timecell_params)
      render json: @timecell.attributes.merge({color: @timecell.define_color, display_value: @timecell.display_value})
    else
      render json: @timecell.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /timecells/1 or /timecells/1.json
  def update_by_time
    if @timecell.update(timecell_params)
      render json: @timecell.attributes.merge({color: @timecell.define_color, display_value: @timecell.display_value})
    else
      render json: @timecell.errors, status: :unprocessable_entity
    end
  end

  # DELETE /timecells/1 or /timecells/1.json
  def destroy
    @timecell.destroy

    respond_to do |format|
      format.html { redirect_to timecells_url, notice: "Timecell was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timecell
      @timecell = Timecell.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def selected_day
      @selected_day = params[:selected_day] ? params[:selected_day].to_datetime : DateTime.now
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_club
      # @club = Price.find(params[:club_id])
      @club = Club.first
    end

    # Only allow a list of trusted parameters through.
    def timecell_params
      params.require(:timecell).permit(:gametable_id, :time, :value, :kind, :tournament_rating, :price, :color)
    end
end
