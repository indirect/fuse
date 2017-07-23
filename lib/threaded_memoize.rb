module ThreadedMemoize

  def threaded_memoize(expires_in:)
    name = caller_locations(1,1)[0].label
    ivar = "#{self.class.name}_#{name}_cache"
    info = Thread.current[ivar]
    now  = Time.now

    if info.nil? || info.fetch(:expires_at) < now
      info = {value: yield, expires_at: now + expires_in}
      Thread.current[ivar] = info
    end

    info[:value]
  end

end