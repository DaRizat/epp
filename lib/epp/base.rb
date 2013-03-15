module Epp
  module Base
    include Epp::Commands
 
    def self.tlds
      Epp::Authentication.enabled_tlds
    end

    def activate_at_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(activate_command)
    end

    def prepare_for_deletion_at_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(prepare_to_delete_command)
    end

    def expire_at_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(expire_command)
    end

    def delete_contact_from_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(delete_contact_command)
    end

    def delete_domain_from_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(delete_domain_command)
    end

    #TODO: Object should know what type they are and this should be one method
    def create_contact_at_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(create_contact_command)
    end

    def create_domain_at_registry
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(create_domain_command)
    end

    def contact_registry_info
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(contact_info_command)
    end

    def domain_registry_info
      transaction = Epp::Transaction.new(self.registry)
      return transaction.request(domain_info_command)
    end

    def get_statuses_for state
      Epp::Config.domain_config[state]
    end
  end
end
