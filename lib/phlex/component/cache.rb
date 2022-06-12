require "digest"

module Phlex::Component::Cache
  def cache_key
    [checksum, assigns]
  end

  def checksum
    file = File.open(Module.const_source_location(self.class.name).first)
    Digest::MD5.hexdigest(file.read)
  end
end
