require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/entered_forms", type: :request do
  let(:attributes) do
    {
      form_id: form_id,
      user_id: current_user.id
    }
  end
  let(:current_user) { create(:user, kind: :guardian, daycare: daycare) }
  let(:form_id) { form.id }
  let(:provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let!(:form) { create(:form, daycare: daycare, users: [current_user]) }
  let(:existing_entered_form) { create(:entered_form, form_id: form_id, user: current_user) }

  before do
    sign_in current_user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_entered_form_path(daycare.id, form_id: form.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_entered_form
      get daycare_entered_form_path(daycare.id, existing_entered_form.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_entered_form
      get edit_daycare_entered_form_path(daycare.id, existing_entered_form.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new entered_form" do
        expect {
          post daycare_entered_forms_path(daycare.id), params: { entered_form: attributes }
        }.to change(EnteredForm, :count).by(1)
      end

      it "redirects to the created entered_form" do
        post daycare_entered_forms_path(daycare.id), params: { entered_form: attributes }
        expect(response.code).to eq "302"
      end
    end

    # context "with invalid parameters" do
    #   let(:form_id) { nil }

    #   it "does not create a new entered_form" do
    #     expect {
    #       post daycare_entered_forms_path(daycare.id), params: { entered_form: attributes }
    #     }.to change(EnteredForm, :count).by(0)
    #   end

    #   it "renders a successful response (i.e. to display the 'new' template)" do
    #     post daycare_entered_forms_path(daycare.id), params: { entered_form: attributes }
    #     expect(response.code).to eq "422"
    #   end
    # end
  end

  describe "PATCH /update" do
    before { existing_entered_form }

    context "with valid parameters" do
      let(:new_form_id) { create(:form, daycare: daycare, users: [current_user]).id }

      it "updates the requested entered_form" do
        patch daycare_entered_form_path(daycare.id, existing_entered_form.id),
              params: { entered_form: attributes }
        existing_entered_form.reload
        expect(response.code).to eq "302"
      end

      it "redirects to the entered_form" do
        patch daycare_entered_form_path(daycare.id, existing_entered_form.id),
              params: { entered_form: attributes }
        expect(response).to redirect_to(daycare_entered_form_path(daycare.id, existing_entered_form.id))
      end
    end

    # context "with invalid parameters" do
    #   let(:new_form_id) { "" }

    #   it "renders a successful response (i.e. to display the 'edit' template)" do
    #     patch daycare_entered_form_path(daycare.id, existing_entered_form.id),
    #           params: { entered_form: new_attributes }
    #     expect(response.code).to eq "422"
    #   end
    # end
  end

  describe "DELETE /destroy" do
    before do
      existing_entered_form
      sign_in provider
    end

    it "destroys the requested entered_form" do
      expect {
        delete daycare_entered_form_path(daycare.id, existing_entered_form.id)
      }.to change(EnteredForm, :count).by(-1)
    end

    it "redirects to the forms list" do
      delete daycare_entered_form_path(daycare.id, existing_entered_form.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
