require 'erb'

module Epp
  class Command
    include LibXML::XML

    def activate

      template = read_template("activate")

      str = epp_header
      xml.root << command_node = Node.new("command")
      command_node << update_node = Node.new("update")
      update_node << domain_update_node = Node.new("domain:update")
      domain_update_node << domain_add_node = Node.new("domain:add")
      domain_update_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_update_node << Node.new("domain:name", full_name)
      domain_add_node << ok_status_node = Node.new("domain:status")
      ok_status_node["s"] = "ok"
      domain_update_node << domain_rem_node = Node.new("domain:rem")
      domain_rem_node << ok_status_node = Node.new("domain:status")
      ok_status_node["s"] = "inactive"
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def transfer       
      xml = epp_header
      xml.root << command_node = Node.new("command")
      #TODO: The transfer has to include ns info, need to consult with Afilias for this.
    end

    def expire
      xml = epp_header
      xml.root << command_node = Node.new("command")
      command_node << update_node = Node.new("update")
      update_node << domain_update_node = Node.new("domain:update")
      domain_update_node << domain_add_node = Node.new("domain:add")
      domain_update_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_update_node << Node.new("domain:name", full_name)
      domain_add_node << del_status_node = Node.new("domain:status")
      del_status_node["s"] = "clientDeleteProhibited"
      domain_add_node << hold_status_node = Node.new("domain:status")
      hold_status_node["s"] = "clientHold"
      domain_add_node << trans_status_node = Node.new("domain:status")
      trans_status_node["s"] = "clientTransferProhibited"
      domain_add_node << update_status_node = Node.new("domain:status")
      update_status_node["s"] = "clientUpdateProhibited"
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def update_before_deletion
      xml = epp_header
      xml.root << command_node = Node.new("command")
      command_node << update_node = Node.new("update")
      update_node << domain_update_node = Node.new("domain:update")
      domain_update_node << domain_rem_node = Node.new("domain:rem")
      domain_update_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_update_node << Node.new("domain:name", full_name)
      domain_rem_node << del_status_node = Node.new("domain:status")
      del_status_node["s"] = "clientDeleteProhibited"
      domain_rem_node << hold_status_node = Node.new("domain:status")
      hold_status_node["s"] = "clientHold"
      domain_rem_node << trans_status_node = Node.new("domain:status")
      trans_status_node["s"] = "clientTransferProhibited"
      domain_rem_node << update_status_node = Node.new("domain:status")
      update_status_node["s"] = "clientUpdateProhibited"
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def create
      xml = epp_header
      xml.root << command_node = Node.new("command")
      command_node << create_node = Node.new("create")
      create_node << domain_create_node = Node.new("domain:create")
      domain_create_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_create_node << Node.new("domain:name", full_name)
      domain_create_node << domain_auth_node = Node.new("domain:authInfo")
      domain_auth_node << Node.new("domain:pw", domain_password)
      domain_create_node << Node.new("domain:registrant", registrant)
      domain_create_node << admin_node = Node.new("domain:contact", registrant)
      admin_node["type"] = "admin"
      domain_create_node << tech_node = Node.new("domain:contact", registrant)
      tech_node["type"] = "tech"
      domain_create_node << billing_node = Node.new("domain:contact", registrant)
      billing_node["type"] = "billing"
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def delete
      xml = epp_header
      xml.root << command_node = Node.new("command")
      command_node << delete_node = Node.new("delete")
      delete_node << domain_delete_node = Node.new("domain:delete")
      domain_delete_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_delete_node << domain_name_node = Node.new("domain:name", full_name)
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def info
      xml = epp_header
      xml.root << command_node = Node.new("command")
      command_node << info_node = Node.new("info")
      info_node << domain_info_node = Node.new("domain:info")
      domain_info_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_info_node << domain_name_node = Node.new("domain:name", full_name)
      domain_info_node['hosts'] = "all"
      domain_info_node << domain_auth_node = Node.new("domain:authInfo")
      domain_auth_node << Node.new("domain:pw", domain_password)
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def renew
      exp_date = Time.at(expiration_date).strftime("%Y-%m-%d")    
      puts "EXPIRATION DATE #{exp_date}"
      xml = epp_header
      xml.root << command_node = Node.new("command")
      command_node << renew_node = Node.new("renew")
      renew_node << domain_renew_node = Node.new("domain:renew")
      domain_renew_node['xmlns:domain'] = "urn:ietf:params:xml:ns:domain-1.0"
      domain_renew_node << domain_name_node = Node.new("domain:name", full_name)
      domain_renew_node << domain_exp_node = Node.new("domain:curExpDate", exp_date)
      domain_renew_node << domain_period_node = Node.new("domain:period", 1)
      domain_period_node['unit'] = "y"
      command_node << Node.new("clTRID", UUIDTools::UUID.timestamp_create.to_s)
      xml.to_s
    end

    def render_template name 
      gem_dir = File.dirname(__FILE__)
      file = File.open("#{gem_dir}/commands/#{name}.xml.erb")
      contents = file.read
      file.close

      template = ERB.new(contents).result(binding)
    end

    def header
      xml = Document.new
      xml.root = Node.new("epp")
      xml.root["xmlns"] = "urn:ietf:params:xml:ns:epp-1.0"
      xml.root["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
      xml.root["xsi:schemaLocation"] = "urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd"
      return xml
    end
  end
end
