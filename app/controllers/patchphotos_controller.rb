class PatchphotosController < ApplicationController
  before_action :set_patchphoto, only: [:show, :edit, :update, :destroy]

  # GET /patchphotos
  # GET /patchphotos.json
  def index
    @patchphotos = Patchphoto.all
  end

  # GET /patchphotos/1
  # GET /patchphotos/1.json
  def show
  end

  # GET /patchphotos/new
  def new
    @patchphoto = Patchphoto.new
  end

  # GET /patchphotos/1/edit
  def edit
  end

  # POST /patchphotos
  # POST /patchphotos.json
  def create
    @patchphoto = Patchphoto.new(patchphoto_params)

    respond_to do |format|
      if @patchphoto.save
        format.html { redirect_to @patchphoto, notice: 'Patchphoto was successfully created.' }
        format.json { render :show, status: :created, location: @patchphoto }
      else
        format.html { render :new }
        format.json { render json: @patchphoto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patchphotos/1
  # PATCH/PUT /patchphotos/1.json
  def update
    respond_to do |format|
      if @patchphoto.update(patchphoto_params)
        format.html { redirect_to @patchphoto, notice: 'Patchphoto was successfully updated.' }
        format.json { render :show, status: :ok, location: @patchphoto }
      else
        format.html { render :edit }
        format.json { render json: @patchphoto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patchphotos/1
  # DELETE /patchphotos/1.json
  def destroy
    @patchphoto.destroy
    respond_to do |format|
      format.html { redirect_to patchphotos_url, notice: 'Patchphoto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patchphoto
      @patchphoto = Patchphoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patchphoto_params
      params.require(:patchphoto).permit(:patch, :parking_id)
    end
end
