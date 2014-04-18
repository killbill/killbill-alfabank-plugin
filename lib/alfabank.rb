require 'action_controller'
require 'active_record'
require 'action_view'
require 'active_merchant'
require 'active_support'
require 'bigdecimal'
require 'money'
require 'pathname'
require 'sinatra'
require 'singleton'
require 'yaml'

require 'killbill'
require 'killbill/helpers/active_merchant'

require 'alfabank/api'
require 'alfabank/private_api'

require 'alfabank/models/payment_method'
require 'alfabank/models/response'
require 'alfabank/models/transaction'

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end
