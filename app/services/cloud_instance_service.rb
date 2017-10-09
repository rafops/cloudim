class CloudInstanceService

  protected

    attr_reader :profile, :region, :client_class, :credentials_class

    def initialize(profile: nil,
                   region: "us-east-1",
                   client_class: Aws::EC2::Client,
                   credentials_class: Aws::SharedCredentials)
      @profile = profile
      @region = region
      @client_class = client_class
      @credentials_class = credentials_class
    end

    def client
      @client ||= lambda {
        client_options = {}
        client_options.merge!(credentials: credentials) if credentials
        client_options.merge!(region: region) if region
        client_class.new(client_options)
      }.call
    end

    def credentials
      @credentials ||= credentials_class.new(profile_name: profile) if profile
    end

end
