require 'erb'

module Epp
  module Commands

    def activate_command
      @epp_objects = [self]
      render_template("activate")
    end

    def contact_info_command
      @epp_objects = [self]
      render_template("contact_info")
    end

    def domain_info_command
      @epp_objects = [self]
      render_template("domain_info")
    end

    def delete_contact_command
      @epp_objects = [self]
      render_template("delete_contact")
    end

    def create_contact_command 
      @epp_objects = [self]
      render_template("create_contact")
    end

    def delete_domain_command
      @epp_objects = [self]
      render_template("delete_domain")
    end

    def create_domain_command
      @epp_objects = [self]
      render_template("create_domain")
    end

#    def create_command
#      @epp_objects = [self]
#      render_template("create")
#    end

#    def delete_command
#      @epp_objects = [self]
#      render_template("delete")
#    end

    def expire_command
      @epp_objects = [self]
      render_template("expire")
    end

    def lock_command
      @epp_objects = [self]
      render_template("lock")
    end

    def login_command username, password, version, lang, extensions
      @username = username
      @password = password
      @version = version
      @lang = lang
      @extensions = extensions
      render_template("login")
    end

    def logout_command
      render_template("logout")
    end

    def prepare_to_delete_command
      @epp_objects = [self]
      render_template("prepare_to_delete")
    end

    def renew_command
      @epp_objects = [self]
      render_template("renew")
    end

    def transfer_command
      @epp_objects = [self]
      render_template("transfer")
    end

    def unlock_command
      @epp_objects = [self]
      render_template("unlock")
    end

    def render_template name 
      xml_dir = File.dirname(Dir.pwd)
      file = File.open("#{Rails.root.join("config", "epp", "#{name}.xml.erb")}")
      contents = file.read
      file.close
      ERB.new(contents).result(binding)
    end

    def object_node_for object, action
      @object = object
      if object.epp_object_type
        render_template("#{object.epp_object_type.to_s}_#{action}")
      else
        raise "epp_object_type property must be set for object #{object}"
      end
    end
  end
end
