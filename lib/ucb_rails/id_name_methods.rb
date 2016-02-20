module UcbRails::IdNameMethods
  extend ActiveSupport::Concern
  DataNotDefinedError = Class.new(StandardError)
  
  included do
    attr_reader :id, :name, :opts
  end
  
  def initialize(id, name, opts={})
    @id = id
    @name = name
    @opts = opts
  end
  
  def == (other)
    self.class == other.class && self.id == other.id
  end

  module ClassMethods
    
    def all
      @all ||= begin
        verify_data_constant
        self::DATA.map { |args| new(*args) }
      end
    end
    
    def values
      @values ||= self::DATA.map(&:first)
    end

    def labels
      @labels ||= self::DATA.map(&:last)
    end

    def find(id)
      all.detect { |instance| instance.id.to_s == id.to_s }
    end
    
    def find_by_name(name)
      all.detect { |instance| instance.name.to_s == name.to_s }      
    end
    
    def name_from_id(id)
      find(id)
        .try(:name)
    end
    
    def id_from_name(name)
      all.detect {|instance| instance.name.to_s == name.to_s}.try(&:id)
    end
    
    def options_for_select
      all
        .map { |e| [e.id, e.name] }
    end

    def const_map
      self.constants.inject({}) do |map, c|
        const_value = self.const_get(c)
        map[c.to_s.downcase] = const_value if const_value.respond_to?(:integer?) && const_value.integer? && self::DATA.detect { |pair| pair[0] == const_value }
        map
      end
    end    

    private
    
    def verify_data_constant
      unless defined?(self::DATA)
        raise DataNotDefinedError, "You must define a DATA constant"
      end
    end
  end
  
end