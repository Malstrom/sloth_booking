class TournamentsController < ApplicationController
  before_action :set_club
  before_action :set_tournament , only: %i[ show edit update destroy ]


  # GET /tournaments or /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1 or /tournaments/1.json
  def show
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments or /tournaments.json
  def create
    @tournament = @club.tournaments.build(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to root_path, notice: "Tournament was successfully created." }
        format.json { render json: @tournament }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1 or /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to root_path, notice: "Tournament was successfully updated." }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1 or /tournaments/1.json
  def destroy
    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Tournament was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:club_id])
    end

    # Only allow a list of trusted parameters through.
    def tournament_params
      params.require(:tournament).permit(:name, :rating, :starts_at, :ends_at, :price)
    end
end
