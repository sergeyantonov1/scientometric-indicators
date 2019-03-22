class SeedLogging
  def self.call(message)
    print message
    result = yield
    puts " Successfully!"

    return result
  rescue => e
    puts " Failed! #{e.message}"
  end
end
