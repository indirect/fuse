module ThreadedMemoize
  # Memoize a block for a given amount of time in a thread-local variable.
  # Somewhat similar to Rails' thread_mattr_accessor, but for results that
  # need to be calculated and then cached for a while.
  #
  # Values are stored by class name and method name. If multiple objects
  # need separate values, they should provide a `key` that corresponds
  # to just that object.
  #
  # @param expires_in [Integer] how many seconds to cache the value for
  # @param key [String] a key to distinguish values calculated by the same class and method
  #
  # @example Cache a time-based signature for 60 seconds
  #   threaded_memoize(expires_in: 60) { calculate_signature }
  #
  # @example Cache a value specific to this object id for ten minutes
  #   threaded_memoize(key: id, expires_in: 600) { create_value }
  #
  # @return the result of the block given to the method
  def threaded_memoize(expires_in:, key: nil)
    name = caller_locations(1,1)[0].label
    ivar = [self.class.name, name, key, "cache"].compact.join("_")
    info = Thread.current[ivar]
    now  = Time.now

    if info.nil? || info.fetch(:expires_at) < now
      info = {value: yield, expires_at: now + expires_in}
      Thread.current[ivar] = info
    end

    info[:value]
  end
end
