module SFImport

  class Insert

    def initialize(hash_list)
      @config = Configuration.instance
      @object_list = []
      @object_class_name = SFImport.const_get(@config.object_type)
      @field_map = @object_class_name.send("map")
      @operation_name = self.class.to_s.downcase.split("::")[1]

      for h in hash_list
        @object_list << @object_class_name.send(:new,h)
      end
    end

    def run
      @config.verify
      @csv_file = make_csv
      @sdl_file = make_sdl
      invoke_dataloader
      cleanup
    end

    private

    def make_csv
      time = Time.now.usec.to_s
      file_name = @config.dldata + "/loadData" + time + ".csv"
      CSV.open(file_name,"w+") do |csv|
        csv << @field_map.values.map do |x|
          x.include?("__c") ? @config.sf_namespace + x : x
        end
        for o in @object_list
          csv << o.to_csv_row
        end
      end
      file_name
    end

    def make_sdl
      sdl = File.open(@config.dlmap + "/#{@config.object_type.downcase}.sdl","w+")
      @field_map.values.each do |x|
        sdl.write "#{x.to_s}=#{x.to_s}\n"
      end
      sdl.close
      sdl.path
    end

    def encrypt_password
      encrypted = "java -cp #{@config.dlpath}/DataLoader.jar " +
      "com.salesforce.dataloader.security.EncryptionUtil -e #{@config.sf_password + @config.sf_sectoken}"
      `#{encrypted}`.gsub("\n","")
    end

    def invoke_dataloader
      call = "java -cp #{@config.dlpath}/DataLoader.jar " +
      "-Dsalesforce.config.dir=#{@config.dlconf} " +
      "com.salesforce.dataloader.process.ProcessRunner " +
      "dataAccess.name=#{@csv_file} " +
      "process.name=#{@operation_name} " +
      "process.mappingFile=#{@sdl_file} " +
      "process.statusOutputDirectory=#{@config.dllog} " +
      "sfdc.username=#{@config.sf_username} " +
      "sfdc.password=#{encrypt_password} " +
      "sfdc.endpoint=#{@config.sf_endpoint} " +
      "sfdc.entity=#{@config.object_type} " +
      "sfdc.loadBatchSize=#{@config.sf_load_batch_size} " +
      "sfdc.extractionRequestSize=#{@config.sf_extraction_request_size}"
      system call
    end

    def cleanup
      File.delete("active_job.properties")
      File.delete(@csv_file)
      File.delete(@sdl_file)
      for file in Dir.glob(@config.dllog + "/*.csv")
        puts file.to_s
        File.delete(file)
      end
    end

  end

end

