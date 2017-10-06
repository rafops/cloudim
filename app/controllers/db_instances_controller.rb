class DbInstancesController < ApplicationController
  before_action :set_db_instance, only: [:show, :edit, :update, :destroy]

  # GET /db_instances
  # GET /db_instances.json
  def index
    @db_instances = DbInstance.all
  end

  # GET /db_instances/1
  # GET /db_instances/1.json
  def show
  end

  # GET /db_instances/new
  def new
    @db_instance = DbInstance.new
  end

  # GET /db_instances/1/edit
  def edit
  end

  # POST /db_instances
  # POST /db_instances.json
  def create
    @db_instance = DbInstance.new(db_instance_params)

    respond_to do |format|
      if @db_instance.save
        format.html { redirect_to @db_instance, notice: 'Db instance was successfully created.' }
        format.json { render :show, status: :created, location: @db_instance }
      else
        format.html { render :new }
        format.json { render json: @db_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_instances/1
  # PATCH/PUT /db_instances/1.json
  def update
    respond_to do |format|
      if @db_instance.update(db_instance_params)
        format.html { redirect_to @db_instance, notice: 'Db instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_instance }
      else
        format.html { render :edit }
        format.json { render json: @db_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_instances/1
  # DELETE /db_instances/1.json
  def destroy
    @db_instance.destroy
    respond_to do |format|
      format.html { redirect_to db_instances_url, notice: 'Db instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_instance
      @db_instance = DbInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_instance_params
      params.require(:db_instance).permit(:name)
    end
end
