# -- encoding : utf-8 --

set :views, File.expand_path(File.dirname(__FILE__) + '/views')

include Killbill::Plugin::ActiveMerchant::Sinatra

configure do
  # Usage: rackup -Ilib -E test
  if development? or test?
    # Make sure the plugin is initialized
    plugin              = ::Killbill::Alfabank::PaymentPlugin.new
    plugin.logger       = Logger.new(STDOUT)
    plugin.logger.level = Logger::INFO
    plugin.conf_dir     = File.dirname(File.dirname(__FILE__)) + '/..'
    plugin.start_plugin
  end
end

helpers do
  def plugin(session = {})
    ::Killbill::Alfabank::PrivatePaymentPlugin.new(:alfabank,
                                                   ::Killbill::Alfabank::AlfabankPaymentMethod,
                                                   ::Killbill::Alfabank::AlfabankTransaction,
                                                   ::Killbill::Alfabank::AlfabankResponse,
                                                   session)
  end
end

# http://127.0.0.1:9292/plugins/killbill-alfabank
get '/plugins/killbill-alfabank' do
  order_number = request.GET['order_number']
  required_parameter! :order_number, order_number

  amount = request.GET['amount']
  required_parameter! :amount, amount

  description = request.GET['description']
  return_url  = request.GET['return_url']

  response = plugin.get_checkout_page(order_number, amount, description, return_url)
  if response.success?
    redirect to(response.params['form_url'])
  else
    logger.warn "Error requesting the checkout page: #{response.message || response.inspect}"
    status 500
    body "Не удалось совершить платёж: #{response.message}"
  end
end

# curl -v http://127.0.0.1:9292/plugins/killbill-alfabank/1.0/pms/1
get '/plugins/killbill-alfabank/1.0/pms/:id', :provides => 'json' do
  if pm = ::Killbill::Alfabank::AlfabankPaymentMethod.find_by_id(params[:id].to_i)
    pm.to_json
  else
    status 404
  end
end

# curl -v http://127.0.0.1:9292/plugins/killbill-alfabank/1.0/transactions/1
get '/plugins/killbill-alfabank/1.0/transactions/:id', :provides => 'json' do
  if transaction = ::Killbill::Alfabank::AlfabankTransaction.find_by_id(params[:id].to_i)
    transaction.to_json
  else
    status 404
  end
end

# curl -v http://127.0.0.1:9292/plugins/killbill-alfabank/1.0/responses/1
get '/plugins/killbill-alfabank/1.0/responses/:id', :provides => 'json' do
  if transaction = ::Killbill::Alfabank::AlfabankResponse.find_by_id(params[:id].to_i)
    transaction.to_json
  else
    status 404
  end
end