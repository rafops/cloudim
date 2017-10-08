class CloudInstanceFetchCommand

  def initialize(profile: nil, 
                 region: nil,
                 cloud_instance_list_service: CloudInstanceListService,
                 instance_model: Instance)
    @profile = profile
    @region = region
    @cloud_instance_list_service = cloud_instance_list_service
    @instance_model = instance_model
  end
  
  def call
    cloud_instance.call.map do |instance|
      record = instance_model.find_or_initialize_by(name: instance["name"])
      new_record = record.new_record?
      record.update_attributes(instance)
      record if new_record
    end.compact
  end

  private
  
  attr_reader :profile,
              :region,
              :cloud_instance_list_service,
              :instance_model

  def cloud_instance
    @cloud_instance ||= cloud_instance_list_service.new(profile: profile, region: region)
  end
end