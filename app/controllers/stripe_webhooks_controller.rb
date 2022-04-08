class StripeWebhooksController < ApplicationController
  protect_from_forgery except: :create

  def create
    if StripeWebhookService.new(request, ENV['STRIPE_API_KEY']).log_event
      head :no_content
    else
      head 500
    end
  end

  def connect
    if StripeWebhookService.new(request, ENV['STRIPE_CONNECT_API_KEY']).log_event
      head :no_content
    else
      head 500
    end
  end
end