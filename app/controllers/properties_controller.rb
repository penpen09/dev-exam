class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @nearest_stations = @property.nearest_stations
  end

  # GET /properties/new
  def new
    @property = Property.new
    2.times { @property.nearest_stations.build }
  end

  # GET /properties/1/edit
  def edit
    @property.nearest_stations.build
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    binding.pry
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_property
    @property = Property.find(params[:id])
  end
  def property_params
    params.require(:property).permit(:name, :rent, :address, :age, :remark, nearest_stations_attributes: [:id, :route_name, :station, :munutes_foot])
  end
end
