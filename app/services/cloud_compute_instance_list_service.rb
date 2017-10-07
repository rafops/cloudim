class CloudComputeInstanceListService < CloudComputeInstanceService

  def initialize(client: nil, **options)
    @client = client || super(options)
  end

  def call
    response_hash(client.describe_instances)
  end

  private

  attr_reader :client

  def response_hash(response)
    response.reservations.map do |reservation|
      reservation.instances.map do |instance|
        ec2_instance_hash(instance)
      end
    end.flatten
  end

  def ec2_instance_hash(instance)
    { "name" => name_from_tags(instance.tags) }
  end

  def name_from_tags(tags)
    name_tag = tags.select { |tag| tag.key == "Name" }.first
    name_tag ? name_tag.value : ""
  end
end
