module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class AlfabankTransaction < ::Killbill::Plugin::ActiveMerchant::ActiveRecord::Transaction

      self.table_name = 'alfabank_transactions'

      belongs_to :alfabank_response

    end
  end
end
