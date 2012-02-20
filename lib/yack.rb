module Yack
  class Callback
    def initialize
      @callbacks = {}
    end

    def process hash
      @callbacks.keys.each{|key|
        _call_back @callbacks[key], hash[key]
      }
    end

    def method_missing m, *args, &block
      block_given? ? @callbacks[m] = block : Handler.new(m, @callbacks)
    end

    private
    def _call_back callback, hash
      return if callback.nil? or hash.nil?
      case(callback)
        when Hash
          callback.keys.each do |key|
            _call_back callback[key], hash[key]
          end
        when Proc
          callback.call(hash)
      end
    end
  end

  class Handler
    def initialize method, callbacks
      callbacks[method] ||= {}
      @callbacks = callbacks[method]
    end

    def method_missing m, *args, &block
      if block_given?
        @callbacks[m] = block
      else
        @callbacks[m] ||= {}
        @callbacks = @callbacks[m]
        return self
      end
    end
  end
end
