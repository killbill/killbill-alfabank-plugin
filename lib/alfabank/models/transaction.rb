module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class AlfabankTransaction < Killbill::Plugin::ActiveMerchant::ActiveRecord::Transaction

      self.table_name = 'alfabank_transactions'

    end
  end
end
