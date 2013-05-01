module InstaReadability
  class Bookmark
    ATTRIBUTES = [:url, :favorite, :archive, :allow_duplicates]
    attr_reader *ATTRIBUTES

    def initialize(options={})
      @archive, @favorite, @allow_duplicates = 0, 0, 0
      options.each_pair { |attr, value| instance_variable_set("@#{attr}", value) }
    end

    def ==(o)
      o.class == self.class && o.to_hash == to_hash
    end
    alias_method :eql?, :==

    def to_hash
      ATTRIBUTES.inject({}) do |hash, attribute|
        hash[attribute] = self.send attribute.to_s
        hash
      end
    end
  end
end
