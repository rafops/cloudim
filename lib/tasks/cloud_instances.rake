namespace :cloud_instances do
  desc "fetch instances from the cloud and populate database with new instances"
  task :fetch, [:profile, :region] => [:environment] do |t, args|
    command = CloudInstancesFetchCommand.new(
      profile: args[:profile],
      region: args[:region]
    )
    command.call
    puts "#{command.count} instances created"
  end

  desc "fetch all instances from all accounts and regions"
  task :fetch_all => [:environment] do
    command = CloudInstancesFetchAllCommand.new(output: STDOUT)
    command.call
    puts "#{command.count} instances created"
  end
end
