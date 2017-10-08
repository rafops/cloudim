class CloudInstancesFetchCommand

  def initialize(profile: nil, 
                 region: nil,
                 cloud_instances_list_service: CloudInstancesListService,
                 instance_model: Instance)
    @profile = profile
    @region = region
    @cloud_instances_list_service = cloud_instances_list_service
    @instance_model = instance_model
  end
  
  def call
    cloud_instances.call.map do |instance|
      record = instance_model.find_or_initialize_by(name: instance["name"])
      new_record = record.new_record?
      record.update_attributes(instance)
      record if new_record
    end.compact
  end

  private
  
  attr_reader :profile,
              :region,
              :cloud_instances_list_service,
              :instance_model

  def cloud_instances
    @cloud_instances ||= cloud_instances_list_service.new(profile: profile, region: region)
  end
end