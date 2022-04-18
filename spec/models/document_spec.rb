require 'rails_helper'

RSpec.describe Document, type: :model do
  it { is_expected.to respond_to(:daycare_id) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:public_to_daycare) }

  describe "#is_valid?" do
    subject { document.valid? }

    let(:daycare) { build(:daycare) }
    let(:document) { build(:document, daycare: daycare, user: user, document: attached_document) }
    let(:attached_document) { Rack::Test::UploadedFile.new('spec/factories/files/test-picture.jpg', 'image/jpeg') }
    let(:user) { build(:user) }

    context "When user is not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end

    context "When daycare not present" do
      let(:daycare) { nil }

      it { is_expected.to be false }
    end

    context "When attached document not present" do
      let(:attached_document) { nil }

      it { is_expected.to be false }
    end
  end
end
