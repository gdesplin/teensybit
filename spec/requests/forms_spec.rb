require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/forms", type: :request do
  let(:attributes) do 
    { 
      title: title,
      user_ids: [guardian.id]
    } 
  end
  let(:title) { Faker::Lorem.word }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:existing_form) { create(:form, daycare: daycare, title: title, users: [guardian]) }

  before do
    sign_in current_user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_form_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_form
      get daycare_form_path(daycare.friendly_id, existing_form.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_form
      get edit_daycare_form_path(daycare.friendly_id, existing_form.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new form" do
        expect {
          post daycare_forms_path(daycare.friendly_id), params: { form: attributes }
        }.to change(Form, :count).by(1)
      end

      it "redirects to the created form" do
        post daycare_forms_path(daycare.friendly_id), params: { form: attributes }
        expect(response.code).to eq "302"
      end

      it "saves progress, renders edit" do
        post daycare_forms_path(daycare.friendly_id), params: { form: attributes, commit: "Save Progress" }
        expect(response.code).to eq "200"
      end

    end

    context "with invalid parameters" do
      let(:title) { nil }

      it "does not create a new form" do
        expect {
          post daycare_forms_path(daycare.friendly_id), params: { form: attributes }
        }.to change(Form, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_forms_path(daycare.friendly_id), params: { form: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { title: new_title } }
    
    before { existing_form }
    
    context "with valid parameters" do
      let(:new_title) { Faker::Lorem.unique.word }

      it "updates the requested form" do
        patch daycare_form_path(daycare.friendly_id, existing_form.id),
              params: { form: new_attributes }
        existing_form.reload
        expect(response.code).to eq "302"
      end

      it "redirects to the form" do
        patch daycare_form_path(daycare.friendly_id, existing_form.id),
              params: { form: new_attributes }
        expect(response).to redirect_to(daycare_form_path(daycare.friendly_id, existing_form.id))
      end

       it "redirects to the edit form" do
        patch daycare_form_path(daycare.friendly_id, existing_form.id),
              params: { form: new_attributes, commit: "Save Progress" }
        expect(response.code).to eq "200"
      end
    end

    context "with invalid parameters" do
      let(:new_title) { "" }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_form_path(daycare.friendly_id, existing_form.id),
              params: { form: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "DELETE /destroy" do
    before { existing_form }

    it "destroys the requested form" do
      expect {
        delete daycare_form_path(daycare.friendly_id, existing_form.id)
      }.to change(Form, :count).by(-1)
    end

    it "redirects to the forms list" do
      delete daycare_form_path(daycare.friendly_id, existing_form.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
