require 'spec_helper'

ActiveMerchant::Billing::Base.mode = :test

describe Killbill::Alfabank::PaymentPlugin do

  include ::Killbill::Plugin::ActiveMerchant::RSpec

  before(:each) do
    @plugin = Killbill::Alfabank::PaymentPlugin.new

    @account_api    = ::Killbill::Plugin::ActiveMerchant::RSpec::FakeJavaUserAccountApi.new
    svcs            = {:account_user_api => @account_api}
    @plugin.kb_apis = Killbill::Plugin::KillbillApi.new('alfabank', svcs)

    @plugin.logger       = Logger.new(STDOUT)
    @plugin.logger.level = Logger::INFO
    @plugin.conf_dir     = File.expand_path(File.dirname(__FILE__) + '../../../../')
    @plugin.start_plugin
  end

  after(:each) do
    @plugin.stop_plugin
  end

  it 'should generate forms correctly' do
    kb_account_id = SecureRandom.uuid
    kb_tenant_id  = SecureRandom.uuid
    context       = @plugin.kb_apis.create_context(kb_tenant_id)
    fields        = @plugin.hash_to_properties({
                                                   :order_number => Time.now.to_i,
                                                   :amount       => 10,
                                                   :description  => 'description',
                                                   :return_url   => 'http://kill-bill.org'
                                               })
    form          = @plugin.build_form_descriptor kb_account_id, fields, [], context

    form.kb_account_id.should == kb_account_id
    form.form_method.should == 'GET'
    form.form_url.should match(/https:\/\/test\.paymentgate\.ru\/testpayment\/merchants\/[a-zA-Z]*\/payment_ru\.html\?mdOrder=[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/)

    form_fields = @plugin.properties_to_hash(form.form_fields)
    form_fields.size.should == 0
  end
end
