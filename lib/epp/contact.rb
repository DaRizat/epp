require 'active_support/concern'

module Epp
  module Contact
    extend ActiveSupport::Concern

    include Epp::Base

    @@epp_object_type = :domain
    @@registries = []

    module ClassMethods
      def enable_registries *registries
        @@registries = registries
      end
    end

    def registry_enabled?
      @@registries.include? self.registry
    end

    def epp_object_type
      @@epp_object_type
    end
  end
end
