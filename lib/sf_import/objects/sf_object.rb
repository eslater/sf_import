module SFImport
  class SFObject

    def initialize(hash)
      if hash.class.to_s != 'Hash'
        raise ArgumentError, "Illegal Arguemnt. Parameter must be hash."
      end
      hash.keys.each { |x|
        if self.respond_to?(x)
          self.send(x.to_s + "=",hash[x])
        end
      }
    end

    def to_csv_row
      row_as_list = []
      for k in self.class.map.keys
        row_as_list << self.send(k).to_s
      end
      row_as_list
    end

  end
end

