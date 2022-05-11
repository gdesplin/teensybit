require 'rails_helper'

RSpec.describe FormPolicy, type: :policy do
  let!(:provider) { create(:user, kind: :provider) }
  let!(:provider_two) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let!(:daycare_two) { create(:daycare, user_id: provider_two.id) }
  let!(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let!(:form_one) { create(:form, daycare: daycare, users: [guardian])}
  let!(:form_two) { create(:form, daycare: daycare_two, users: [])}

  subject { described_class }

  permissions ".scope" do
    it "only shows forms providers owned daycare has" do
      expect(FormPolicy::Scope.new(provider, Form).resolve).to eq provider.owned_daycare&.forms
    end
  end

  permissions :show? do
    it "denies if form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, form_two)
    end
    it "accepts if form does belong to providers owned daycare" do
      expect(subject).to permit(provider, form_one)
    end
  end

  permissions :new? do
    it "denies if form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, form_two)
    end
    it "accepts if form does belong to providers owned daycare" do
      expect(subject).to permit(provider, form_one)
    end
  end

  permissions :update? do
    it "denies if form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, form_two)
    end
    it "accepts if form does belong to providers owned daycare" do
      expect(subject).to permit(provider, form_one)
    end
  end

  permissions :edit? do
    it "denies if form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, form_two)
    end
    it "accepts if form does belong to providers owned daycare" do
      expect(subject).to permit(provider, form_one)
    end
  end

  permissions :destroy? do
    it "denies if form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, form_two)
    end
    it "accepts if form does belong to providers owned daycare" do
      expect(subject).to permit(provider, form_one)
    end
  end
end
