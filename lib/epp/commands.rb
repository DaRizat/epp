require 'erb'

module Epp
  module Commands

    def activate_at_registry
      @epp_objects = [self]
      render_template("activate")
    end

    def create_domain_at_registry domain, contact_id
      @domain = domain
      @contact_id = contact_id
      render_template("create_domain")
    end

    def create_at_registry
      @epp_objects = [self]
      render_template("create")
    end

    def delete_at_registry
      @epp_objects = [self]
      render_template("delete")
    end

    def expire_at_registry
      @epp_objects = [self]
      render_template("expire")
    end

    def lock_at_registry
      @epp_objects = [self]
      render_template("lock")
    end

    def epp_login username, password, version, lang, extensions
      @username = username
      @password = password
      @version = version
      @lang = lang
      @extensions = extensions
      render_template("login")
    end

    def epp_logout
      render_template("logout")
    end

    def prepare_to_delete_at_registry
      @epp_objects = [self]
      render_template("prepare_to_delete")
    end

    def registry_info
      @epp_objects = [self]
      render_template("info")
    end

    def renew_at_registry
      @epp_objects = [self]
      render_template("renew")
    end

    def transfer_at_registry
      @epp_objects = [self]
      render_template("transfer")
    end

    def unlock_at_registry
      @epp_objects = [self]
      render_template("unlock")
    end

    def render_template name 
      gem_dir = File.dirname(__FILE__)
      file = File.open("#{gem_dir}/commands/#{name}.xml.erb")
      contents = file.read
      file.close

      ERB.new(contents).result(binding)
    end

    def object_node_for object, action
      if object.epp_object_type
        render_template("#{object.epp_object_type.to_s}_#{action}")
      else
        raise "epp_object_type property must be set for object #{object}"
      end
    end
  end
end
