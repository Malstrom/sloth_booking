class PricesController < ApplicationController
  before_action :set_price, only: %i[ show edit update destroy ]
  before_action :set_club, only: %i[ index ]

  # GET /prices or /prices.json
  def index
    @selected_day = params[:selected_day].to_datetime
    @days = Date.today..(Date.today + 6.day)
    @gametables = Gametable.where(club: @club)
    @prices_by_hours = Price.group_prices_by_hours(@club, @selected_day)
  end


  # GET /prices/1 or /prices/1.json
  def show; end

  # GET /prices/new
  def new
    @price = Price.new
  end

  # GET /prices/1/edit
  def edit; end

  # POST /prices or /prices.json
  def create
    @price = Price.new(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to price_url(@price), notice: "Price was successfully created." }
        format.json { render :show, status: :created, location: @price }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prices/1 or /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to price_url(@price), notice: "Price was successfully updated." }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1 or /prices/1.json
  def destroy
    @price.destroy

    respond_to do |format|
      format.html { redirect_to prices_url, notice: "Price was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_price
    @price = Price.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    # @club = Price.find(params[:club_id])
    @club = Club.first
  end

  # Only allow a list of trusted parameters through.
  def price_params
    params.fetch(:price, {})
  end
end
