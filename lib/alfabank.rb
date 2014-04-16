require 'active_record'
require 'active_merchant'
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
