class CityTownsController < ApplicationController
  before_action :set_city_town, only: [:show, :edit, :update, :destroy]

  # GET /city_towns
  # GET /city_towns.json
  def index
    @city_towns = CityTown.all
  end

  # GET /city_towns/1
  # GET /city_towns/1.json
  def show
  end

  # GET /city_towns/new
  def new
    @city_town = CityTown.new
  end

  # GET /city_towns/1/edit
  def edit
  end

  # POST /city_towns
  # POST /city_towns.json
  def create
    @city_town = CityTown.new(city_town_params)

    respond_to do |format|
      if @city_town.save
        format.html { redirect_to @city_town, notice: 'City town was successfully created.' }
        format.json { render :show, status: :created, location: @city_town }
      else
        format.html { render :new }
        format.json { render json: @city_town.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /city_towns/1
  # PATCH/PUT /city_towns/1.json
  def update
    respond_to do |format|
      if @city_town.update(city_town_params)
        format.html { redirect_to @city_town, notice: 'City town was successfully updated.' }
        format.json { render :show, status: :ok, location: @city_town }
      else
        format.html { render :edit }
        format.json { render json: @city_town.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /city_towns/1
  # DELETE /city_towns/1.json
  def destroy
    @city_town.destroy
    respond_to do |format|
      format.html { redirect_to city_towns_url, notice: 'City town was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_town
      @city_town = CityTown.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_town_params
      params.require(:city_town).permit(:name, :area)
    end
end
