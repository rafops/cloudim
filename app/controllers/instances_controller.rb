class InstancesController < ApplicationController
  before_action :set_instance, only: [:show]

  # GET /instances
  # GET /instances.json
  def index
    @instances = Instance.head
  end

  # GET /instances/1
  # GET /instances/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = Instance.find(params[:id])
    end

end
