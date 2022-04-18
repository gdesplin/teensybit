require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { is_expected.to respond_to(:daycare_id) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:public_to_daycare) }

  describe "#is_valid?" do
    subject { picture.valid? }

    let(:daycare) { build(:daycare) }
    let(:picture) { build(:picture, daycare: daycare, user: user, picture: attached_picture) }
    let(:attached_picture) { Rack::Test::UploadedFile.new('spec/factories/files/test-picture.jpg', 'image/jpeg') }
    let(:user) { build(:user) }

    context "When user is not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end

    context "When daycare not present" do
      let(:daycare) { nil }

      it { is_expected.to be false }
    end

    context "When attached picture not present" do
      let(:attached_picture) { nil }

      it { is_expected.to be false }
    end
  end
end
