module Epp
  class Authentication
    @@config = YAML::load(File.open("#{Dir.pwd}/config/epp.yml"))
    @@registry_conf = @@config[Rails.env]

    @@tlds = []
    @@registries = []

    def self.enabled_tlds
      @@tlds
    end

    def self.enabled_registries 
      @@registries
    end

    def self.enable_registries *registries
      registries.each do |reg|
        @@registries.push reg
        case reg
          when :verisign
            @@tlds.push("com", "net")
          when :afilias
            @@tlds.push "info"
          when :pir
            @@tlds.push "org"
          when :namestore
            @@tlds.push("cc", "tv")
          when :neustar_us
            @@tlds.push "us"
          when :neustar_biz
            @@tlds.push "biz"
        end
      end     
    end

    def registry_enabled? registry
      enabled_registries.include? registry
    end

    def self.get_attributes_for registry
#      if registry_enabled? registry
        @@registry_conf[registry.to_s].symbolize_keys!
#      else
#        raise "Provided registry is not enabled! Please include it in enabled_registries in your EppRecord model!"
#      end
    end
  end
end
