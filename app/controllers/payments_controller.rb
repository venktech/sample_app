class PaymentsController < ApplicationController
include ActiveMerchant::Billing

  def index

  end

  def confirm
  redirect_to :action => 'index' unless params[:token]

  details_response = gateway.details_for(params[:token])

  if !details_response.success?
    @message = details_response.message
    render :action => 'error'
    return
  end
  @address = details_response.address

  end

  def complete
purchase = gateway.purchase(5000,
    :ip       => request.remote_ip,
    :payer_id => params[:payer_id],
    :token    => params[:token]
  )
  
  if !purchase.success?
    @message = purchase.message
    render :action => 'error'
    return
  end
  end
  def checkout
  setup_response = EXPRESS_GATEWAY.setup_purchase(5000,
    :ip                => request.remote_ip,
    :return_url        => url_for(:action => 'confirm', :only_path => false),
    :cancel_return_url => url_for(:action => 'index', :only_path => false)
  )
  redirect_to EXPRESS_GATEWAY.redirect_url_for(setup_response.token)
  end

#private
 # def gateway
#@gateway ||= PaypalExpressGateway.new(
 #   :login => 'venkte_1331656958_biz_api1.gmail.com',
  #  :password => '1331656983',
  #  :signature => 'AFcWxV21C7fd0v3bYYYRCpSSRl31AC9I9jg1MB.0OFHjtzDHwSOnb.TQ'
 # )
#end


end
