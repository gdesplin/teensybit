require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/stripe_prices", type: :request do
  let(:attributes) do 
    { 
      stripe_id: stripe_id,
      stripe_product_id: stripe_product.id,
      user_id: current_user.id,
      kind: :recurring,
      amount: amount,
      nickname: Faker::Lorem.word,
      recurring: { "interval" => "week", "interval_count" => 1 }
    } 
  end
  let(:amount) { Faker::Number.positive }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
  let(:stripe_account) { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }
  let(:stripe_product) { create(:stripe_product, stripe_account: stripe_account) }
  let(:existing_stripe_price) do
    create(:stripe_price,
     stripe_id: stripe_id,
     stripe_product: stripe_product,
     user: current_user,
     kind: :recurring,
     amount: amount
   )
 end

  before do
    sign_in current_user
  end

  describe "GET #index" do
    it "renders a successful response" do
      existing_stripe_price
      get daycare_stripe_prices_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_stripe_price_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_stripe_price
      get daycare_stripe_price_path(daycare.friendly_id, existing_stripe_price.id)
      expect(response).to be_successful
    end
  end

  # describe "POST /create" do
  #   context "with valid parameters" do

  #     it "creates a new stripe_price" do
  #       expect {
  #         post daycare_stripe_prices_path(daycare.friendly_id), params: { stripe_price: attributes }
  #       }.to change(StripePrice, :count).by(1)
  #     end

  #     it "redirects to the created stripe_price" do
  #       post daycare_stripe_prices_path(daycare.friendly_id), params: { stripe_price: attributes }
  #       expect(response.code).to redirect_to([:provider_dashboard, :daycares])
  #     end
  #   end

  #   context "with invalid parameters" do
  #     let(:amount) { nil }

  #     it "does not create a new stripe_price" do
  #       expect {
  #         post daycare_stripe_prices_path(daycare.friendly_id), params: { stripe_price: attributes }
  #       }.to change(StripePrice, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post daycare_stripe_prices_path(daycare.friendly_id), params: { stripe_price: attributes }
  #       expect(response.code).to eq "422"
  #     end
  #   end
  # end

  describe "DELETE /destroy" do
    before { existing_stripe_price }

    it "redirects to the stripe_prices list" do
      delete daycare_stripe_price_path(daycare.friendly_id, existing_stripe_price.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
