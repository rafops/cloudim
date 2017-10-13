class InstancesController < ApplicationController
  before_action :set_instance, only: [:show]

  # GET /instances
  # GET /instances.json
  def index
    if params[:search]
      term = "%#{params[:search]}%"
      @instances = Instance.where("name like ? OR instance_id like ? OR public_ip_address like ? OR \
      private_ip_address like ? OR public_dns_name like ? OR vpc_id like ? OR subnet_id like ?",\
      term, term, term, term, term, term, term)
    else
      @instances = Instance.head
    end
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
