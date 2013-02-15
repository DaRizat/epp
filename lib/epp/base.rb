module Epp
  class Base
    include Epp::Commands
    include Epp::Transaction

    @epp_object_type = nil

    def epp_object_type type
      case type
        when :domain, :contact, :name_transaction
          @epp_object_type = type
        else
          raise "Unsupported epp_object_type provided: #{type}"
    end 

    def epp_create 
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(create_command)
      end
    end

    def activate_at_registry
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(activate_command)
      end
    end

    def prepare_for_deletion_at_registry
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(update_before_deletion_command)
      end
    end

    def expire_at_registry
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(expire_command)
      end
    end

    def delete_from_registry
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(delete_command)
      end
    end

    def create_at_registry
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(create_command)
      end
    end

    def registry_info
      if registry_enabled?
        transaction = EppRecord::Transaction.new(registry)
        return transaction.request(info_command)
      end
    end
  end
end
