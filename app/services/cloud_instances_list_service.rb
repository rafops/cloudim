class CloudInstancesListService < CloudInstancesService

  def call
    to_h(client.describe_instances)
  end

  private

  def to_h(response)
    response.reservations.map do |reservation|
      reservation.instances.map do |instance|
        instance_to_h(instance)
      end
    end.flatten
  end

  def instance_to_h(instance)
    { "name" => name_from_tags(instance.tags) }
  end

  def name_from_tags(tags)
    name_tag = tags.select { |tag| tag.key == "Name" }.first
    name_tag ? name_tag.value : ""
  end
end
