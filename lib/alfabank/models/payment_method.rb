module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class AlfabankPaymentMethod < ::Killbill::Plugin::ActiveMerchant::ActiveRecord::PaymentMethod

      self.table_name = 'alfabank_payment_methods'

      def external_payment_method_id
        alfabank_token
      end
    end
  end
end
