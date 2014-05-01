module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class PaymentPlugin < ::Killbill::Plugin::ActiveMerchant::PaymentPlugin

      def initialize
        gateway_builder = Proc.new do |config|
          ::ActiveMerchant::Billing::AlfabankGateway.new :account => config[:account],
                                                         :secret  => config[:secret]
        end

        super(gateway_builder,
              :alfabank,
              ::Killbill::Alfabank::AlfabankPaymentMethod,
              ::Killbill::Alfabank::AlfabankTransaction,
              ::Killbill::Alfabank::AlfabankResponse)
      end

      def authorize_payment(kb_account_id, kb_payment_id, kb_payment_method_id, amount, currency, properties, context)
        # Pass extra parameters for the gateway here
        options = {}

        properties = merge_properties(properties, options)
        super(kb_account_id, kb_payment_id, kb_payment_method_id, amount, currency, properties, context)
      end

      def capture_payment(kb_account_id, kb_payment_id, kb_payment_method_id, amount, currency, properties, context)
        # Pass extra parameters for the gateway here
        options = {}

        properties = merge_properties(properties, options)
        super(kb_account_id, kb_payment_id, kb_payment_method_id, amount, currency, properties, context)
      end

      def void_payment(kb_account_id, kb_payment_id, kb_payment_method_id, properties, context)
        # Pass extra parameters for the gateway here
        options = {}

        properties = merge_properties(properties, options)
        super(kb_account_id, kb_payment_id, kb_payment_method_id, properties, context)
      end

      def process_payment(kb_account_id, kb_payment_id, kb_payment_method_id, amount, currency, properties, context)
        # Pass extra parameters for the gateway here
        options = {}

        properties = merge_properties(properties, options)
        super(kb_account_id, kb_payment_id, kb_payment_method_id, amount, currency, properties, context)
      end

      def get_payment_info(kb_account_id, kb_payment_id, properties, context)
        super
      end

      def search_payments(search_key, offset, limit, properties, context)
        super
      end

      def process_refund(kb_account_id, kb_payment_id, refund_amount, currency, properties, context)
        # Pass extra parameters for the gateway here
        options = {}

        properties = merge_properties(properties, options)
        super(kb_account_id, kb_payment_id, refund_amount, currency, properties, context)
      end

      def get_refund_info(kb_account_id, kb_payment_id, properties, context)
        super
      end

      def search_refunds(search_key, offset, limit, properties, context)
        super
      end

      def add_payment_method(kb_account_id, kb_payment_method_id, payment_method_props, set_default, properties, context)
        # Nothing to do
      end

      def delete_payment_method(kb_account_id, kb_payment_method_id, properties, context)
        # Pass extra parameters for the gateway here
        options = {}

        properties = merge_properties(properties, options)
        super(kb_account_id, kb_payment_method_id, properties, context)
      end

      def get_payment_method_detail(kb_account_id, kb_payment_method_id, properties, context)
        super
      end

      def set_default_payment_method(kb_account_id, kb_payment_method_id, properties, context)
        # TODO
      end

      def get_payment_methods(kb_account_id, refresh_from_gateway, properties, context)
        super
      end

      def search_payment_methods(search_key, offset, limit, properties, context)
        super
      end

      def reset_payment_methods(kb_account_id, payment_methods, properties, context)
        super
      end

      def build_form_descriptor(kb_account_id, descriptor_fields, properties, context)
        options                  = properties_to_hash(descriptor_fields)
        gw_response              = gateway.make_order(options)
        response, transaction    = save_response_and_transaction gw_response, :build_form_descriptor, kb_account_id, context.tenant_id

        # Build the response object
        descriptor               = ::Killbill::Plugin::Model::HostedPaymentPageFormDescriptor.new
        descriptor.kb_account_id = kb_account_id
        descriptor.form_method   = 'GET'
        descriptor.form_url      = gw_response.params['form_url']
        descriptor.form_fields   = hash_to_properties({})
        descriptor.properties    = hash_to_properties(gw_response.params)

        descriptor
      end

      def process_notification(notification, properties, context)
        # Pass extra parameters for the gateway here
        options    = {}
        properties = merge_properties(properties, options)

        super(notification, properties, context) do |gw_notification, service|
          # Retrieve the payment
          # gw_notification.kb_payment_id =
          #
          # Set the response body
          # gw_notification.entity =
        end
      end
    end
  end
end
