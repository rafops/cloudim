class CloudInstanceFetchCommand

  def initialize(account: nil,
                 region: nil,
                 cloud_instance_list_service: CloudInstanceListService,
                 instance_model: Instance)
    @account = account
    @region = region
    @cloud_instance_list_service = cloud_instance_list_service
    @instance_model = instance_model
  end

  def call
    instance_model.where(account: account, region: region).transaction do
      instance_model.where(valid_until: Float::INFINITY).update_all(valid_until: Time.now)
      list_service.call.map do |instance_attributes|
        instance_model.create(instance_attributes)
      end.compact
    end
  end

  private

    attr_reader :account,
                :region,
                :cloud_instance_list_service,
                :instance_model

    def list_service
      @list_service ||= cloud_instance_list_service.new(profile: account.profile, region: region)
    end

end
