module SFImport
  class Configuration

    include Singleton

    #---------
    # Defaults
    #---------

    def initialize
      #login
      @sf_username = nil
      @sf_password = nil
      @sf_sectoken = nil
      @sf_endpoint = "https://www.salesforce.com"

      #object type
      @object_type = nil

      #package namespace
      @sf_namespace = ""

      #config
      @sf_load_batch_size = "200"
      @sf_extraction_request_size = "300"
      @sf_endpoint_version = "19.0"

      #pathing
      @project_base = File.expand_path(File.dirname(__FILE__))
      @dlpath = @project_base + "/ApexDataloader"
      @dlbin = @dlpath + "/bin"
      @dlconf = @dlpath + "/conf"
      @dldata = @dlpath + "/write"
      @dllog = @dlpath + "/log"
      @dlmap = @dlpath + "/maps"
    end

    #----------
    # Accessors
    #----------

    attr_accessor :sf_username
    attr_accessor :sf_password
    attr_accessor :sf_sectoken
    attr_accessor :sf_endpoint

    #object to load
    attr_accessor :object_type

    #package namespace
    attr_accessor :sf_namespace

    #Dataloader config
    attr_accessor :sf_load_batch_size
    attr_accessor :sf_extraction_request_size
    attr_accessor :sf_endpoint_version

    #pathing
    attr_accessor :project_base
    attr_accessor :dlpath
    attr_accessor :dlbin
    attr_accessor :dlconf
    attr_accessor :dldata
    attr_accessor :dllog
    attr_accessor :dlmap

    def verify
      nil #implement
    end

  end
end