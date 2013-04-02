# Gem and other dependencies
require 'rubygems'
require 'openssl'
require 'libxml'
require 'hpricot'
require 'uuidtools'
require 'yaml'

# Package files
require File.dirname(__FILE__) + '/require_parameters.rb'
require File.dirname(__FILE__) + '/epp/config.rb'
require File.dirname(__FILE__) + '/epp/transaction.rb'
require File.dirname(__FILE__) + '/epp/exceptions.rb'
require File.dirname(__FILE__) + '/epp/commands.rb'
require File.dirname(__FILE__) + '/epp/authentication.rb'
require File.dirname(__FILE__) + '/epp/base.rb'
require File.dirname(__FILE__) + '/epp/domain.rb'
require File.dirname(__FILE__) + '/epp/contact.rb'

module Epp #:nodoc:
end
