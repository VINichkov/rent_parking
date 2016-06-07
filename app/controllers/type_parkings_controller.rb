class TypeParkingsController < ApplicationController
  before_action :set_type_parking, only: [:show, :edit, :update, :destroy]

  # GET /type_parkings
  # GET /type_parkings.json
  def index
    @type_parkings = TypeParking.all
  end

  # GET /type_parkings/1
  # GET /type_parkings/1.json
  def show
  end

  # GET /type_parkings/new
  def new
    @type_parking = TypeParking.new
  end

  # GET /type_parkings/1/edit
  def edit
  end

  # POST /type_parkings
  # POST /type_parkings.json
  def create
    @type_parking = TypeParking.new(type_parking_params)

    respond_to do |format|
      if @type_parking.save
        format.html { redirect_to @type_parking, notice: 'Type parking was successfully created.' }
        format.json { render :show, status: :created, location: @type_parking }
      else
        format.html { render :new }
        format.json { render json: @type_parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_parkings/1
  # PATCH/PUT /type_parkings/1.json
  def update
    respond_to do |format|
      if @type_parking.update(type_parking_params)
        format.html { redirect_to @type_parking, notice: 'Type parking was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_parking }
      else
        format.html { render :edit }
        format.json { render json: @type_parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_parkings/1
  # DELETE /type_parkings/1.json
  def destroy
    @type_parking.destroy
    respond_to do |format|
      format.html { redirect_to type_parkings_url, notice: 'Type parking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_parking
      @type_parking = TypeParking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_parking_params
      params.require(:type_parking).permit(:Name)
    end
end
