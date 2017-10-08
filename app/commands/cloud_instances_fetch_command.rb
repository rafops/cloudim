class CloudInstancesFetchCommand
  attr_reader :count

  def initialize(service: nil, profile: nil, region: nil)
    @service = service || CloudInstancesListService.new(profile: profile, region: region)
    @count = 0
  end
  
  def call
    instances = @service.call
    instances.each do |instance|
      unless Instance.find_by_name(instance["name"])
        @count = @count + 1 if Instance.create(instance)
      end
    end
  end

  private

  attr_reader :service
end