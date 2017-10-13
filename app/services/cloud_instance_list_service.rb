class CloudInstanceListService < CloudInstanceService

  INSTANCE_STRING_ATTRIBUTES = [
    "image_id",
    "instance_id",
    "instance_type",
    "key_name",
    "private_dns_name",
    "private_ip_address",
    "public_dns_name",
    "public_ip_address",
    "state_transition_reason",
    "subnet_id",
    "vpc_id",
    "architecture",
    "client_token",
    "hypervisor",
    "root_device_name",
    "root_device_type",
    "virtualization_type",
    "launch_time"
  ]

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
      attributes = Hash[INSTANCE_STRING_ATTRIBUTES.map { |k| [k, instance[k] || ""] }]
      attributes.merge!({ "name" => name_from_tags(instance.tags) })
    end

    def name_from_tags(tags)
      name_tag = tags.select { |tag| tag.key == "Name" }.first
      name_tag ? name_tag.value : ""
    end

end
