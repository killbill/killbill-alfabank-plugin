module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class AlfabankPaymentMethod < Killbill::Plugin::ActiveMerchant::ActiveRecord::PaymentMethod

      self.table_name = 'alfabank_payment_methods'

    end
  end
end
