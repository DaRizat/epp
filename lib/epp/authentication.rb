module Epp
  class Authentication

    @@config = YAML::load(File.open("#{Dir.pwd}/config/epp.yml"))
    @@registry_conf = @@config[Rails.env]

    def self.get_attributes_for registry
      @@registry_conf[registry.to_s]
    end

    def self.action_enabled? registry, action
      @@registry_conf[registry.to_s]["actions"].include? action
    end

    def self.enabled_tlds
      tlds = []
      @@registry_conf.each_key do |key|
        if @@registry_conf[key]["actions"] && @@registry_conf[key]["actions"].count > 0
          case key
            when "verisign"
              tlds.concat ["com", "net"]       
            when "namestore"
              tlds.concat ["cc", "tv"]
            when "neustar_biz"
              tlds.concat ["biz"]
            when "neustar_us"
              tlds.concat ["us"]
            when "pir"
              tlds.concat ["org"]
            when "afilias"
              tlds.concat ["info"]
          end
        end
      end
      tlds  
    end
  end
end
