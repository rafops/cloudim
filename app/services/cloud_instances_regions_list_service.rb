class CloudInstancesRegionsListService < CloudInstancesService

  def call
    to_a(client.describe_regions)
  end

  private

  def to_a(response)
    response.regions.map { |r| r.region_name }
  end
end
