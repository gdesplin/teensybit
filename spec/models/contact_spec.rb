require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:notes) }
  it { is_expected.to respond_to(:message) }
  it { is_expected.to respond_to(:opt_in_emails) }
  it { is_expected.to respond_to(:source) }

  describe "#is_valid?" do
    subject { contact.valid? }

    let(:source) { :get_started }
    let(:email) { Faker::Internet.email }
    let(:contact) { build(:contact, source: source, email: email) }

    context "When email is not present" do
      let(:email) { nil }

      it { is_expected.to be false }
    end

    context "When source not present" do
      let(:source) { nil }

      it { is_expected.to be false }
    end
  end
end
