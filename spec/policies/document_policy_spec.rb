require 'rails_helper'

RSpec.describe DocumentPolicy, type: :policy do
  let(:provider) { create(:user, kind: :provider) }
  let(:provider_two) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:daycare_two) { create(:daycare, user_id: provider_two.id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:document_one) { create(:document, users: [guardian], daycare: daycare, user: provider)}
  let(:document_two) { create(:document, daycare: daycare, user: provider)}
  let(:document_three) { create(:document, user: provider_two, daycare: daycare_two)}

  subject { described_class }

  permissions ".scope" do
    it "only shows documents providers owned daycare has" do
      provider.reload; daycare.reload; guardian.reload; document_one.reload; document_two.reload; document_three.reload
      expect(DocumentPolicy::Scope.new(provider, Document).resolve).to eq provider.owned_daycare.documents.order(updated_at: :desc)
    end
    it "only shows documents guardians users are in" do
      provider.reload; daycare.reload; guardian.reload; document_one.reload; document_two.reload; document_three.reload
      expect(DocumentPolicy::Scope.new(guardian, Document).resolve).to eq guardian.documents.order(updated_at: :desc)
    end
  end

  permissions :show? do
    it "denies if document doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, document_three)
    end
    it "accepts if document does belong to providers owned daycare" do
      expect(subject).to permit(provider, document_one)
    end
    it "denies if document's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(guardian, document_two)
    end
    it "accepts if document's guardian does belong to daycare" do
      expect(subject).to permit(guardian, document_one)
    end
  end

  permissions :new? do
    it "denies if document doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, Document.new(user: provider_two, daycare: daycare_two))
    end
    it "accepts if document does belong to providers owned daycare" do
      expect(subject).to permit(provider, Document.new(user: provider, daycare: daycare))
    end
  end

  permissions :update? do
    it "denies if document doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, document_three)
    end
    it "accepts if document does belong to providers owned daycare" do
      expect(subject).to permit(provider, document_one)
    end
  end

  permissions :edit? do
    it "denies if document doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, document_three)
    end
    it "accepts if document does belong to providers owned daycare" do
      expect(subject).to permit(provider, document_one)
    end
  end

  permissions :destroy? do
    permissions :update? do
      it "denies if document doesn't belong to providers owned daycare" do
        expect(subject).not_to permit(provider, document_three)
      end
      it "accepts if document does belong to providers owned daycare" do
        expect(subject).to permit(provider, document_one)
      end
    end
  end
end
