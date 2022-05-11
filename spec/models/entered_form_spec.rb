require 'rails_helper'

RSpec.describe EnteredForm, type: :model do
  it { is_expected.to respond_to(:form_id) }
  it { is_expected.to respond_to(:user_id) }

  describe "#is_valid?" do
    subject { entered_form.valid? }

    let(:user) { build(:user) }
    let(:entered_form) { build(:entered_form, form: form, user: user) }
    let(:form) { build(:form) }

    context "When form is not present" do
      let(:form) { nil }

      it { is_expected.to be false }
    end

    context "When user not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end
  end
end
