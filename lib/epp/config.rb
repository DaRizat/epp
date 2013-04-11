module Epp
  class Config

    @@config = YAML::load(File.open("#{Dir.pwd}/config/epp.yml"))

    def self.registry_config
      @@config[Rails.env]
    end

    def self.domain_config
      @@config['domain_states']
    end
  end
end
