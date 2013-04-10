module Epp
  module Base
    include Epp::Commands
 
    def self.tlds
      Epp::Authentication.enabled_tlds
    end

    def poll registry
      transaction = Epp::Transaction.new(registry)
      return transaction.poll_queue
    end

    def transition_to_state state
      transaction = Epp::Transaction.new(self.registry)
      command = state_transition_command :to => to_state
      return transaction.request(command)
    end

    def transition_between_states from_state, to_state
      transaction = Epp::Transaction.new(self.registry)
      command = state_transition_command :from => from_state, :to => to_state
      return transaction.request(command)
    end

    def activate_at_registry
      transition_to_state :active
    end

    def prepare_for_deletion_at_registry
      transition_to_state :active
    end

    def expire_at_registry
      transition_to_state :autorenew_grace_period
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
