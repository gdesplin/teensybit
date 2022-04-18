require 'rails_helper'

RSpec.describe EnteredFormField, type: :model do
  it { is_expected.to respond_to(:entered_form_id) }
  it { is_expected.to respond_to(:entered_string) }
  it { is_expected.to respond_to(:entered_text) }
  it { is_expected.to respond_to(:entered_datetime) }
  it { is_expected.to respond_to(:entered_date) }
  it { is_expected.to respond_to(:entered_time) }
  it { is_expected.to respond_to(:form_field_id) }

  describe "#is_valid?" do
    subject { entered_form_field.valid? }

    let(:user) { build(:user) }
    let(:entered_form) { build(:entered_form, form: form, user: user) }
    let(:form) { build(:form) }
    let(:form_field) { build(:form_field, form: form) }
    let(:entered_form_field) { build(:entered_form_field, entered_form: entered_form, form_field: form_field) }

    context "When entered_form is not present" do
      let(:entered_form) { nil }

      it { is_expected.to be false }
    end

    context "When form_field not present" do
      let(:form_field) { nil }

      it { is_expected.to be false }
    end
  end
end
