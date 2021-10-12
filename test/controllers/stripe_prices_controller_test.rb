require "test_helper"

class StripePricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stripe_price = stripe_prices(:one)
  end

  test "should get index" do
    get stripe_prices_url
    assert_response :success
  end

  test "should get new" do
    get new_stripe_price_url
    assert_response :success
  end

  test "should create stripe_price" do
    assert_difference('StripePrice.count') do
      post stripe_prices_url, params: { stripe_price: { active: @stripe_price.active, currency: @stripe_price.currency, nickname: @stripe_price.nickname, stripe_id: @stripe_price.stripe_id, stripe_recurring_id: @stripe_price.stripe_recurring_id, kind: @stripe_price.kind, unit_amount: @stripe_price.unit_amount } }
    end

    assert_redirected_to stripe_price_url(StripePrice.last)
  end

  test "should show stripe_price" do
    get stripe_price_url(@stripe_price)
    assert_response :success
  end

  test "should get edit" do
    get edit_stripe_price_url(@stripe_price)
    assert_response :success
  end

  test "should update stripe_price" do
    patch stripe_price_url(@stripe_price), params: { stripe_price: { active: @stripe_price.active, currency: @stripe_price.currency, nickname: @stripe_price.nickname, stripe_id: @stripe_price.stripe_id, stripe_recurring_id: @stripe_price.stripe_recurring_id, kind: @stripe_price.kind, unit_amount: @stripe_price.unit_amount } }
    assert_redirected_to stripe_price_url(@stripe_price)
  end

  test "should destroy stripe_price" do
    assert_difference('StripePrice.count', -1) do
      delete stripe_price_url(@stripe_price)
    end

    assert_redirected_to stripe_prices_url
  end
end
