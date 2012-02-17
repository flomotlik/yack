require 'yaml'

module Yack
  class Callback
    def initialize
      @groups = {}
    end

    def process_yaml yaml
      yaml = YAML::load(yaml)
      yaml.each{|key, value|
        _call_back yaml, @groups
      }
    end

    def method_missing m, *args, &block
      block_given? ? @groups[m] = block : Handler.new(m, @groups)
    end

    private
    def _call_back key, value
      return if key.nil? or value.nil?
      case(key)
        when Hash
          _call_back key[key.keys.first], value[key.keys.first]
        else
          value.call(key)
      end
    end
  end

  class Handler
    def initialize method, groups
      groups[method] ||= {}
      @groups = groups[method]
    end

    def method_missing m, *args, &block
      if block_given?
        @groups[m] = block
      else
        @groups[m] ||= {}
        @groups = @groups[m]
        return self
      end
    end
  end
end
