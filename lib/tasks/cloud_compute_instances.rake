namespace :instances do
  desc "fetch instances from the cloud and populate database with new instances"
  task :fetch, [:profile, :region] => [:environment] do |t, args|
    instances = CloudComputeInstanceListService.new(profile: args[:profile], region: args[:region]).call
    count = 0
    instances.each do |instance|
      unless Instance.find_by_name(instance["name"])
        count = count + 1 if Instance.create(instance)
      end
    end
    puts "#{count} instances created"
  end

end
