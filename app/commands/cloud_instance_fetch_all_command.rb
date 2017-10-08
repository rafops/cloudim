class CloudInstanceFetchAllCommand
  def initialize(cloud_instance_region_list_service: CloudInstanceRegionListService,
                 cloud_instance_fetch_command: CloudInstanceFetchCommand,
                 account_model: Account,
                 logger: nil)
    @cloud_instance_region_list_service = cloud_instance_region_list_service
    @cloud_instance_fetch_command = cloud_instance_fetch_command
    @account_model = account_model
    @logger = logger
  end
  
  def call
    profiles.map do |profile|
      regions(profile: profile).map do |region|
        added = fetch(profile: profile, region: region)
        logger.info "added #{added.count} instances from profile #{profile} and region #{region}" if logger
        added
      end
    end.flatten
  end

  private

  attr_reader :cloud_instance_region_list_service,
              :cloud_instance_fetch_command,
              :account_model,
              :logger

  def profiles
    account_model.pluck(:name)
  end

  def regions(profile:)
    cloud_instance_region_list_service.new(profile: profile).call
  end

  def fetch(profile:, region:)
    command = cloud_instance_fetch_command.new(
      profile: profile,
      region: region
    )
    command.call
  end
end