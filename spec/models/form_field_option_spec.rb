require 'rails_helper'

RSpec.describe FormFieldOption, type: :model do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:form_field_id) }
  it { is_expected.to respond_to(:position) }

  describe "#is_valid?" do
    subject { form_field_option.valid? }

    let(:form_field) { create(:form_field, form: form) }
    let(:owner) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:form) { create(:form, daycare: daycare) }
    let(:other_form_field) { create(:form_field, form: form) }
    let(:form_field_option) { build(:form_field_option, form_field: form_field, name: name) }
    let(:name) { Faker::Lorem.unique.word }

    context "When form_field_id is not present" do
      let(:form_field) { nil }

      it { is_expected.to be false }
    end

    context "When name not present" do
      let(:name) { nil }

      it { is_expected.to be false }
    end

    context "When name is present in another form field" do
      before { create(:form_field_option, name: name, form_field: other_form_field) }

      it { is_expected.to be true }
    end

    context "When name is present in same form field" do
      before { create(:form_field_option, name: name, form_field: form_field) }

      it { is_expected.to be false }
    end
  end
end
