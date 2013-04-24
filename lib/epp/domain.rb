module Epp
  module Domain
    include Epp::Base

    @@epp_object_type = :domain
    @@registries = []

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

    def request_tranfer_in 
      request_domain_transfer_in
    end

    def request_transfer_out
      request_domain_transfer_out
    end
  
    def renew_at_registry term = 1
      renew_domain_at_registry term
    end
  end
end
