module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class PrivatePaymentPlugin
      include Singleton

      def get_checkout_page(order_number, amount, description, return_url)
        gateway.make_order({:order_number => order_number,
                            :amount => amount.to_i,
                            :description => description,
                            :return_url => return_url})
      end

      private

      def kb_apis
        ::Killbill::Plugin::ActiveMerchant.kb_apis
      end

      def gateway
       ::Killbill::Plugin::ActiveMerchant.gateway
      end
    end
  end
end
