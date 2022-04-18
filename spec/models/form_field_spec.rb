require 'rails_helper'

RSpec.describe FormField, type: :model do
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:form_id) }
  it { is_expected.to respond_to(:field_kind) }
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:question) }
  it { is_expected.to respond_to(:required) }

  describe "#is_valid?" do
    subject { form_field.valid? }

    let(:form_field) { build(:form_field, question: question, form: form) }
    let(:owner) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:form) { create(:form, daycare: daycare) }
    let(:other_form) { create(:form, daycare: daycare) }
    let(:question) { Faker::Lorem.unique.words }

    context "When form_id is not present" do
      let(:form) { nil }

      it { is_expected.to be false }
    end

    context "When question not present" do
      let(:question) { nil }

      it { is_expected.to be false }
    end

    context "When question is present in another form" do
      before { create(:form_field, question: question, form: other_form) }

      it { is_expected.to be true }
    end

    context "When question is present in same form" do
      before { create(:form_field, question: question, form: form) }

      it { is_expected.to be false }
    end
  end
end
