require 'rails_helper'

RSpec.describe BroadcastMessagePolicy, type: :policy do
  let!(:provider) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let!(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:broadcast_message) { build(:broadcast_message, sender: provider)}

  subject { described_class }

  permissions :new? do
    it "denies if broadcast message sender isn't a daycare owner" do
      expect(subject).not_to permit(guardian, broadcast_message)
    end
    it "accepts if broadcast message sender is a daycare owner" do
      expect(subject).to permit(provider, broadcast_message)
    end
  end

  permissions :create? do
    it "denies if broadcast message sender isn't a daycare owner" do
      expect(subject).not_to permit(guardian, broadcast_message)
    end
    it "accepts if broadcast message sender is a daycare owner" do
      expect(subject).to permit(provider, broadcast_message)
    end
  end
end
