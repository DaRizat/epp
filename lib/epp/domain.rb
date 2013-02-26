require 'active_support/concern'

module Epp
  module Domain
    extend ActiveSupport::Concern

    include Epp::Base

    @@epp_object_type = :domain
    @@registries = []

    module ClassMethods
      def enable_registries *registries
        puts "Enabling Reg #{registries}"
        @@registries = registries
        puts "#{@@registries}"
      end
    end

    def registry_enabled?
      @@registries.include? self.registry
    end

    def epp_object_type
      @@epp_object_type
    end

    def registry_info
      domain_registry_info
    end
  
    def create_at_registry
      create_domain_at_registry
    end

    def delete_from_registry
      delete_domain_from_registry
    end
  end
end
