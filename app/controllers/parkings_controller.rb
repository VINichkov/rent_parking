class ParkingsController < ApplicationController
  before_action :set_parking, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /parkings
  # GET /parkings.json
  def index
    @parkings = Parking.all
  end

  def index_json
    @parkings = []
    Parking.all.each do |elem|
      @parkings <<  {lat:elem.latitude, lng:elem.langitude, title:elem.name}
    end
  end

  # GET /parkings/1
  # GET /parkings/1.json
  def show
  end

  # GET /parkings/new
  def new
    @parking = Parking.new
  end

  # GET /parkings/1/edit
  def edit
  end

  # POST /parkings
  # POST /parkings.json
  def create
    param = parking_params
    @parking = Parking.new(param)
    respond_to do |format|
      if @parking.save
        flag = true
        @images.each do |image|
          @potos = Patchphoto.new(parking_id:@parking.id,image:image)
          unless @potos.save
            Patchphoto.find_by_parking_id(@parking.id).each do |image|
              image.delete
            end
            @parking.delete
            flag = false
          end
        end
        if flag
          format.html { redirect_to(@parking, notice: 'Parking was successfully created.') }
          format.json { render :show, status: :created, location: @parking }
        else
          format.html { render :new }
          format.json { render json: @potos.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parkings/1
  # PATCH/PUT /parkings/1.json
  def update
    respond_to do |format|
      if @parking.update(parking_params)
        format.html { redirect_to @parking, notice: 'Parking was successfully updated.' }
        format.json { render :show, status: :ok, location: @parking }
      else
        format.html { render :edit }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parkings/1
  # DELETE /parkings/1.json
  def destroy
    @parking.destroy
    respond_to do |format|
      format.html { redirect_to parkings_url, notice: 'Parking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking
      @parking = Parking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_params
      @images=[]
      if !params[:parking][:image].nil? then
        params[:parking][:image].each do |image|
          @images<<image
        end
      end
      params.require(:parking).permit(:name, :adress, :latitude, :langitude, :accessible, :open24, :covered, :sitestaff, :overnight, :valet, :restrictions, :descriptions, :price, :typerent, :user_id)
    end
end
