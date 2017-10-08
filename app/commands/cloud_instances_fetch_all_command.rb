class CloudInstancesFetchAllCommand
  def initialize(cloud_instances_regions_list_service: CloudInstancesRegionsListService,
                 cloud_instances_fetch_command: CloudInstancesFetchCommand,
                 account_model: Account,
                 logger: nil)
    @cloud_instances_regions_list_service = cloud_instances_regions_list_service
    @cloud_instances_fetch_command = cloud_instances_fetch_command
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

  attr_reader :cloud_instances_regions_list_service,
              :cloud_instances_fetch_command,
              :account_model,
              :logger

  def profiles
    account_model.pluck(:name)
  end

  def regions(profile:)
    cloud_instances_regions_list_service.new(profile: profile).call
  end

  def fetch(profile:, region:)
    command = cloud_instances_fetch_command.new(
      profile: profile,
      region: region
    )
    command.call
  end
end