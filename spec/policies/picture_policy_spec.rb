require 'rails_helper'

RSpec.describe PicturePolicy, type: :policy do
  let!(:provider) { create(:user, kind: :provider) }
  let(:pundit_user) { DaycareUserContext.new(provider, daycare) }
  let(:guardian_pundit_user) { DaycareUserContext.new(guardian, daycare) }
  let(:pundit_user_wrong) { DaycareUserContext.new(provider, daycare_two) }
  let(:guardian_pundit_user_wrong) { DaycareUserContext.new(guardian, daycare_two) }
  let!(:provider_two) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let!(:daycare_two) { create(:daycare, user_id: provider_two.id) }
  let!(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let!(:child) { create(:child, users: [guardian], daycare: daycare)}
  let!(:picture_one) { create(:picture, children: [child], daycare: daycare, user: provider)}
  let!(:picture_two) { create(:picture, daycare: daycare, user: provider)}
  let!(:picture_three) { create(:picture, user: provider_two, daycare: daycare_two)}

  subject { described_class }

  permissions ".scope" do
    it "only shows pictures providers owned daycare has" do
      expect(PicturePolicy::Scope.new(pundit_user, Picture).resolve).to eq provider.owned_daycare.pictures.order(updated_at: :desc)
    end
    it "only shows pictures guardians children are in" do
      expect(PicturePolicy::Scope.new(guardian_pundit_user, Picture).resolve).to eq guardian.pictures.order(updated_at: :desc)
    end
  end

  permissions :show? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(pundit_user, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(pundit_user, picture_one)
    end
    it "denies if picture's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(guardian_pundit_user, picture_two)
    end
    it "accepts if picture's guardian does belong to daycare" do
      expect(subject).to permit(guardian_pundit_user, picture_one)
    end
  end

  permissions :index? do
    it "denies if provider doesn't own to daycare" do
      expect(subject).not_to permit(pundit_user_wrong, nil)
    end
    it "accepts if provider does own to daycare" do
      expect(subject).to permit(pundit_user, nil)
    end
    it "denies if guardian doesn't belong to daycare" do
      expect(subject).not_to permit(guardian_pundit_user_wrong, nil)
    end
    it "accepts if guardian does belong to daycare" do
      expect(subject).to permit(guardian_pundit_user, nil)
    end
  end

  permissions :new? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(pundit_user, Picture.new(user: provider_two, daycare: daycare_two))
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(pundit_user, Picture.new(user: provider, daycare: daycare))
    end
  end

  permissions :update? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(pundit_user, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(pundit_user, picture_one)
    end
  end

  permissions :edit? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(pundit_user, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(pundit_user, picture_one)
    end
  end

  permissions :destroy? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(pundit_user, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(pundit_user, picture_one)
    end
  end
end
