class StripePricesController < ApplicationController
  before_action :set_stripe_price, only: %i[show edit update index]
  before_action :set_daycare

  # GET /stripe_prices
  def index
    @stripe_prices = StripePrice.all
  end

  # GET /stripe_prices/1
  def show
  end

  # GET /stripe_prices/new
  def new
    @stripe_price = StripePrice.new
  end

  # GET /stripe_prices/1/edit
  def edit
  end

  # POST /stripe_prices
  def create
    @stripe_price = @daycare.stripe_account.stripe_products.first.stripe_prices.new(stripe_price_params)
    stripe_price_hash = @stripe_price.as_json.symbolize_keys
    stripe_price_hash[:stripe_account_id] = @daycare.stripe_account.stripe_id
    @stripe_price.recurring["interval_count"] = @stripe_price.recurring["interval_count"].to_i if @stripe_price.recurring["interval_count"].present?
    render :new and return unless @stripe_price.valid?

    stripe_price_object = StripeSession.new.create_price(stripe_price_hash)
    @stripe_price.stripe_id = stripe_price_object.id
    @stripe_price.active = stripe_price_object.active
    if @stripe_price.save
      redirect_to [@daycare, @stripe_price], notice: 'Stripe price was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stripe_prices/1
  def update
    respond_to do |format|
      if @stripe_price.update(stripe_price_params)
        redirect_to [@daycare, @stripe_price], notice: 'Stripe price was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /stripe_prices/1
  def destroy
    price = StripePrice.find(params[:id])
    StripeSession.new.set_price_to_inactive(price.stripe_id, @daycare.stripe_account.stripe_id)
    redirect_to [:dashboard, :daycares], notice: 'Stripe price was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stripe_price
      @stripe_price = StripePrice.find(params[:id])
    end

    def set_daycare
      @daycare = Daycare.find(params[:daycare_id])
    end

    # Only allow a list of trusted parameters through.
    def stripe_price_params
      params.require(:stripe_price).permit(:currency, :nickname, :unit_amount, :amount, recurring: [:interval_count, :interval], user_ids: [])
    end
end
