module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class AlfabankResponse < Killbill::Plugin::ActiveMerchant::ActiveRecord::Response

      self.table_name = 'alfabank_responses'

    end
  end
end
