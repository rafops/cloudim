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
    accounts.map do |account|
      regions(account: account).map do |region|
        records = fetch(account: account, region: region)
        logger.info "imported #{records.count} #{"instance".pluralize(records.count)} from account #{account.name} and region #{region}" if logger
        records
      end
    end.flatten
  end

  private

    attr_reader :cloud_instance_region_list_service,
                :cloud_instance_fetch_command,
                :account_model,
                :logger

    def accounts
      account_model.all
    end

    def regions(account:)
      cloud_instance_region_list_service.new(profile: account.profile).call
    end

    def fetch(account:, region:)
      command = cloud_instance_fetch_command.new(
        account: account,
        region: region
      )
      command.call
    end

end
