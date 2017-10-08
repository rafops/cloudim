namespace :cloud_instances do
  desc "fetch instances from the cloud and populate database with new instances"
  task :fetch, [:profile, :region] => [:environment] do |t, args|
    command = CloudInstancesFetchCommand.new(
      profile: args[:profile],
      region: args[:region]
    )
    created = command.call
    puts "created #{created.count} instances"
  end

  desc "fetch all instances from all accounts and regions"
  task :fetch_all => [:environment] do
    command = CloudInstancesFetchAllCommand.new(logger: Logger.new(STDOUT))
    created = command.call
    puts "created #{created.count} instances"
  end
end
