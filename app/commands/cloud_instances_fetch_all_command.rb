class CloudInstancesFetchAllCommand
  attr_reader :count, :output

  def initialize(output: nil)
    @count = 0
    @output = output
  end
  
  def call
    profiles.each do |profile|
      regions(profile: profile).each do |region|
        added = fetch(profile: profile, region: region)
        @count = @count + added
        output.print "added #{added} instances from profile #{profile} and region #{region}\n" if output
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