require 'rails_helper'

RSpec.describe EnteredFormPolicy, type: :policy do
  let!(:provider) { create(:user, kind: :provider) }
  let!(:alt_provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:alt_daycare) { create(:daycare, user_id: alt_provider.id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:alt_guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:form) { create(:form, daycare: daycare, users: [guardian]) }
  let!(:entered_form) { create(:entered_form, form: form, user: guardian) }

  subject { described_class }
  
  permissions ".scope" do
    it "only shows providers daycares entered forms" do
      expect(EnteredFormPolicy::Scope.new(provider, EnteredForm).resolve).to eq provider.owned_daycare.entered_forms.order(updated_at: :desc)
    end
    it "only shows guardians entered forms" do
      expect(EnteredFormPolicy::Scope.new(guardian, EnteredForm).resolve).to eq guardian.entered_forms.order(updated_at: :desc)
    end
  end

  permissions :create? do
    it "denies if entered_form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(alt_provider, entered_form)
    end
    it "denies if entered_form's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, entered_form)
    end
    it "accepts if entered_form's guardian does belong to daycare" do
      expect(subject).to permit(guardian, entered_form)
    end
  end

  permissions :new? do
    it "denies if entered_form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(alt_provider, entered_form)
    end
    it "denies if entered_form's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, entered_form)
    end
    it "accepts if entered_form's guardian does belong to daycare" do
      expect(subject).to permit(guardian, entered_form)
    end
  end

  permissions :update? do
    it "denies if entered_form does belong to user, even daycare provider" do
      expect(subject).not_to permit(provider, entered_form)
    end
    it "denies if entered_form's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, entered_form)
    end
    it "accepts if entered_form's guardian does belong to daycare" do
      expect(subject).to permit(guardian, entered_form)
    end
  end

  permissions :edit? do
    it "denies if entered_form does belong to user, even daycare provider" do
      expect(subject).not_to permit(provider, entered_form)
    end
    it "denies if entered_form's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, entered_form)
    end
    it "accepts if entered_form's guardian does belong to daycare" do
      expect(subject).to permit(guardian, entered_form)
    end
  end


  permissions :show? do
    it "denies if entered_form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(alt_provider, entered_form)
    end
    it "accepts if entered_form does belong to providers owned daycare" do
      expect(subject).to permit(provider, entered_form)
    end
    it "denies if entered_form's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, entered_form)
    end
    it "accepts if entered_form's guardian does belong to daycare" do
      expect(subject).to permit(guardian, entered_form)
    end
  end

  permissions :destroy? do
    it "denies if entered_form doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(alt_provider, entered_form)
    end
    it "accepts if entered_form does belong to providers owned daycare" do
      expect(subject).to permit(provider, entered_form)
    end
    it "denies if entered_form's guardian attempts to delete" do
      expect(subject).not_to permit(guardian, entered_form)
    end
  end
end
