module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class PrivatePaymentPlugin < ::Killbill::Plugin::ActiveMerchant::PrivatePaymentPlugin
      def get_checkout_page(order_number, amount, description, return_url)
        gateway.make_order({:order_number => order_number,
                            :amount       => amount.to_i,
                            :description  => description,
                            :return_url   => return_url})
      end
    end
  end
end
