class CloudInstancesFetchAllCommand
  attr_reader :count

  def initialize
    @count = 0
  end
  
  def call
    profiles.each do |profile|
      regions(profile: profile).each do |region|
        @count = @count + fetch(profile: profile, region: region)
      end
    end
  end

  private

  def profiles
    Account.pluck(:name)
  end

  def regions(profile:)
    CloudInstancesService.new(profile: profile).regions
  end

  def fetch(profile:, region:)
    command = CloudInstancesFetchCommand.new(
      profile: profile,
      region: region
    )
    command.call
    command.count
  end

  attr_reader :service
end