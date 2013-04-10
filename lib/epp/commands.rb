require 'erb'

module Epp
  module Commands
    def state_transition_command opts
      from_state = (opts[:from]) ? opts[:from] : self.state
      to_state = opts[:to]
      @statuses_removed = Epp::Config.domain_status_for from_state
      @statuses_added = Epp::Config.domain_status_for to_state
      render_template("update")
    end

    def command_node_for command
       
    end

    def render_template name 
      xml_dir = File.dirname(Dir.pwd)
      file = File.open("#{Rails.root.join("config", "epp", "#{name}.xml.erb")}")
      contents = file.read
      file.close
      ERB.new(contents).result(binding)
    end
  end
end
