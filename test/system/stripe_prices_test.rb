require "application_system_test_case"

class StripePricesTest < ApplicationSystemTestCase
  setup do
    @stripe_price = stripe_prices(:one)
  end

  test "visiting the index" do
    visit stripe_prices_url
    assert_selector "h1", text: "Stripe Prices"
  end

  test "creating a Stripe price" do
    visit stripe_prices_url
    click_on "New Stripe Price"

    fill_in "Active", with: @stripe_price.active
    fill_in "Currency", with: @stripe_price.currency
    fill_in "Nickname", with: @stripe_price.nickname
    fill_in "Stripe", with: @stripe_price.stripe_id
    fill_in "Stripe recurring", with: @stripe_price.stripe_recurring_id
    fill_in "Kind", with: @stripe_price.kind
    fill_in "Unit amount", with: @stripe_price.unit_amount
    click_on "Create Stripe price"

    assert_text "Stripe price was successfully created"
    click_on "Back"
  end

  test "updating a Stripe price" do
    visit stripe_prices_url
    click_on "Edit", match: :first

    fill_in "Active", with: @stripe_price.active
    fill_in "Currency", with: @stripe_price.currency
    fill_in "Nickname", with: @stripe_price.nickname
    fill_in "Stripe", with: @stripe_price.stripe_id
    fill_in "Stripe recurring", with: @stripe_price.stripe_recurring_id
    fill_in "Kind", with: @stripe_price.kind
    fill_in "Unit amount", with: @stripe_price.unit_amount
    click_on "Update Stripe price"

    assert_text "Stripe price was successfully updated"
    click_on "Back"
  end

  test "destroying a Stripe price" do
    visit stripe_prices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stripe price was successfully destroyed"
  end
end
