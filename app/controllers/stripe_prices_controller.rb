class StripePricesController < ApplicationController
  before_action :set_daycare
  before_action :set_stripe_price, only: %i[index destroy]
  before_action :authorize_stripe_price, only: %i[index destroy]

  def index
    @stripe_prices = stripe_price_scope
  end

  def new
    @stripe_price = StripePrice.new
  end

  def create
    @stripe_price = @daycare.stripe_account.stripe_products.first.stripe_prices.new(stripe_price_params)
    stripe_price_hash = @stripe_price.as_json.symbolize_keys
    stripe_price_hash[:stripe_account_id] = @daycare.stripe_account.stripe_id
    @stripe_price.recurring["interval_count"] = @stripe_price.recurring["interval_count"].to_i if @stripe_price.recurring["interval_count"].present?
    render :new and return unless @stripe_price.valid?

    stripe_price_object = StripeSession.new.create_price(stripe_price_hash)
    @stripe_price.stripe_id = stripe_price_object.id
    @stripe_price.active = stripe_price_object.active
    authorize_stripe_price
  
    if @stripe_price.save
      redirect_to [@daycare, @stripe_price], notice: 'Stripe price was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    DeactivateStripePriceJob.perform_later(price.stripe_id, @daycare.stripe_account.stripe_id)
    redirect_to [:provider_dashboard, :daycares], notice: 'Stripe price was successfully destroyed.'
  end

  private

  def set_stripe_price
    @stripe_price = stripe_price_scope.find(params[:id])
  end

  def set_daycare
    @daycare = current_user.owned_daycare
  end

  def stripe_price_scope
    @daycare.stripe_account.stripe_prices
  end

  def stripe_price_params
    params.require(:stripe_price).permit(:currency, :nickname, :unit_amount, :amount, :user_id, recurring: [:interval_count, :interval])
  end

  def authorize_stripe_price
    authorize @stripe_price
  end

end
