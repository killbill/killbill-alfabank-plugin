module Killbill #:nodoc:
  module Alfabank #:nodoc:
    class AlfabankResponse < ::Killbill::Plugin::ActiveMerchant::ActiveRecord::Response

      self.table_name = 'alfabank_responses'

      has_one :alfabank_transaction

      def self.from_response(api_call, kb_account_id, kb_payment_id, kb_tenant_id, response, extra_params = {})
        super(api_call,
              kb_account_id,
              kb_payment_id,
              kb_tenant_id,
              response,
              {
                  # Pass custom key/values here
                  #:params_id => extract(response, 'id'),
                  #:params_card_id => extract(response, 'card', 'id')
              }.merge!(extra_params),
              ::Killbill::Alfabank::AlfabankResponse)
      end
    end
  end
end
