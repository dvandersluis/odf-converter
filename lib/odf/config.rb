require 'active_support/configurable'

module ODF
  # Configures global settings for ODF
  #   ODF.configure do |config|
  #     config.port = 3111
  #   end
  def self.configure(&block)
    yield @config ||= ODF::Configuration.new
  end

  # Global settings for ODF::Converter
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    
    config_accessor :office_bin
    config_accessor :connection_type
    config_accessor :host
    config_accessor :port
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.office_bin = "soffice"
    config.connection_type = :socket
    config.host = :localhost
    config.port = 2083 
  end
end