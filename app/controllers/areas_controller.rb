class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
    respond_to do |format|
        format.html {render 'areas/index'}
        format.json  {render 'areas/index'}

        end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_area_session
    session[:area]=params[:id]
    puts "_________________Задали параметр #{session[:area]}"
    respond_to do |format|
      format.json {render json: "{\"status\":\"true\"}"}
      format.any {render json: "{\"status\":\"true\"}"}
    end
  end

  def get_area_session
    @get_area = Area.find_by_id(session[:area])
    if @get_area.nil?
      puts "_________________Получили значение nil"
      respond_to do |format|
        format.json {render json: "{id:0, \"name\":\"nil\"}"}
      end
    else
      puts "_________________Получили значение #{@get_area.name}"
      respond_to do |format|
        format.json {render 'areas/get_area_session'}
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name)
    end
end
