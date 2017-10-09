class DbInstancesController < ApplicationController
  before_action :set_db_instance, only: [:show]

  # GET /db_instances
  # GET /db_instances.json
  def index
    @db_instances = DbInstance.all
  end

  # GET /db_instances/1
  # GET /db_instances/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_instance
      @db_instance = DbInstance.find(params[:id])
    end

end
