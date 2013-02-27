module Epp
  module Base
    include Epp::Commands
 
    def self.tlds
      Epp::Authentication.enabled_tlds
    end

    #TODO: Move registry enabled actions logic into epp config file and restore the enabled check here
    def activate_at_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(activate_command)
     # end
    end

    def prepare_for_deletion_at_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(prepare_to_delete_command)
     # end
    end

    def expire_at_registry
     # if registry_enabled?
        if(self.registry == :neustar_biz || self.registy == :neustar_us)
          prepare_neustar_expiration
        else
          transaction = Epp::Transaction.new(self.registry)
          return transaction.request(expire_command)
        end
     # end
    end

    def prepare_neustar_expiration
      
    end

    def delete_contact_from_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(delete_contact_command)
     # end
    end

    def delete_domain_from_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(delete_domain_command)
     # end
    end

    #TODO: Object should know what type they are and this should be one method
    def create_contact_at_registry
      # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(create_contact_command)
      # end
    end

    def create_domain_at_registry
      # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        #TODO: Figure out how to best implement a generic contact ID solution
        return transaction.request(create_domain_command)
      # end
    end

    def contact_registry_info
      # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(contact_info_command)
      # end
    end

    def domain_registry_info
      # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(domain_info_command)
      # end
    end
  end
end
