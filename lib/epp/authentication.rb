module Epp
  class Authentication

    @@config = Epp::Config.registry_config

    def self.get_attributes_for registry
      @@config[registry.to_s].symbolize_keys!
    end

    def self.action_enabled? registry, action
      @@config[registry.to_s]["actions"].include? action
    end

    def self.enabled_tlds
      tlds = []
      @@config.each_key do |key|
        if @@config[key]["actions"] && @@config[key]["actions"].count > 0
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
