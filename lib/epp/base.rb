module Epp
  module Base

    include Epp::Commands
    
    def epp_create 
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(create_domain_at_registry(self, "nameking_test"))
     # end
    end

    def activate_at_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(activate_command)
     # end
    end

    def prepare_for_deletion_at_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(update_before_deletion_command)
     # end
    end

    def expire_at_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(expire_command)
     # end
    end

    def delete_from_registry
     # if registry_enabled?
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(delete_command)
     # end
    end

    def create_at_registry
      puts "is THIS happening?"
      # if registry_enabled?
        puts self.registry
        transaction = Epp::Transaction.new(self.registry)
        return transaction.request(create_domain_at_registry(self, "nameking_test"))
      # end
    end

    def registry_info
      # if registry_enabled?
        #transaction = Epp::Transaction.new(self.registry)
        return transaction.request(info_command)
      # end
    end
  end
end
