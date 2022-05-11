require 'rails_helper'

RSpec.describe StripePricePolicy, type: :policy do
  let(:pundit_user) { DaycareUserContext.new(provider, daycare) }
  let(:alt_pundit_user) { DaycareUserContext.new(alt_provider, daycare) }
  let(:provider) { create(:user, kind: :provider) }
  let(:alt_provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:stripe_account) { create(:stripe_account, daycare_id: daycare.id) }
  let(:stripe_product) { create(:stripe_product, stripe_account_id: stripe_account.stripe_id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:stripe_price) { create(:stripe_price, stripe_product_id: stripe_product.stripe_id, user_id: guardian.id) }

  subject { described_class }

  permissions :index? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(alt_pundit_user, StripePrice.new(stripe_product_id: stripe_product.id))
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(pundit_user, stripe_price)
    end
  end

  permissions :create? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(alt_pundit_user, StripePrice.new(stripe_product_id: stripe_product.id))
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(pundit_user, stripe_price)
    end
  end

  permissions :new? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(alt_pundit_user, StripePrice.new(stripe_product_id: stripe_product.id))
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(pundit_user, stripe_price)
    end
  end

  permissions :destroy? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(alt_pundit_user, StripePrice.new(stripe_product_id: stripe_product.id))
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(pundit_user, stripe_price)
    end
  end

end
