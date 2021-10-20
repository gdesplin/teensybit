require 'rails_helper'

RSpec.describe PicturePolicy, type: :policy do
  let(:provider) { create(:user, kind: :provider) }
  let(:provider_two) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:daycare_two) { create(:daycare, user_id: provider_two.id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:child) { create(:child, users: [guardian], daycare: daycare)}
  let(:picture_one) { create(:picture, children: [child], daycare: daycare, user: provider)}
  let(:picture_two) { create(:picture, daycare: daycare, user: provider)}
  let(:picture_three) { create(:picture, user: provider_two, daycare: daycare_two)}

  subject { described_class }

  permissions ".scope" do
    it "only shows pictures providers owned daycare has" do
      provider.reload; daycare.reload; guardian.reload; child.reload; picture_one.reload; picture_two.reload; picture_three.reload
      expect(PicturePolicy::Scope.new(provider, Picture).resolve).to eq provider.owned_daycare.pictures
    end
    it "only shows pictures guardians children are in" do
      provider.reload; daycare.reload; guardian.reload; child.reload; picture_one.reload; picture_two.reload; picture_three.reload
      expect(PicturePolicy::Scope.new(guardian, Picture).resolve).to eq guardian.pictures
    end
  end

  permissions :show? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(provider, picture_one)
    end
    it "denies if picture's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(guardian, picture_two)
    end
    it "accepts if picture's guardian does belong to daycare" do
      expect(subject).to permit(guardian, picture_one)
    end
  end

  permissions :new? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, Picture.new(user: provider_two, daycare: daycare_two))
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(provider, Picture.new(user: provider, daycare: daycare))
    end
  end

  permissions :update? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(provider, picture_one)
    end
  end

  permissions :edit? do
    it "denies if picture doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, picture_three)
    end
    it "accepts if picture does belong to providers owned daycare" do
      expect(subject).to permit(provider, picture_one)
    end
  end

  permissions :destroy? do
    permissions :update? do
      it "denies if picture doesn't belong to providers owned daycare" do
        expect(subject).not_to permit(provider, picture_three)
      end
      it "accepts if picture does belong to providers owned daycare" do
        expect(subject).to permit(provider, picture_one)
      end
    end
  end
end
