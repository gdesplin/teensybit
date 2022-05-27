require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/documents", type: :request do
  let(:attributes) do 
    { 
      title: title,
      description: Faker::Lorem.words,
      public_to_daycare: false,
      document: attaching_document,
      child_ids: [] 
    } 
  end
  let(:title) { Faker::Lorem.words }
  let(:attaching_document) { Rack::Test::UploadedFile.new('spec/factories/files/test-picture.jpg', 'image/jpeg') }
  let(:provider) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let(:attached_document) { Rack::Test::UploadedFile.new('spec/factories/files/test-picture-alt.jpg', 'image/jpeg') }
  let(:existing_document) { create(:document, daycare: daycare, user: provider, document: attached_document) }


  before do
    sign_in provider
  end

  describe "GET #index" do
    it "renders a successful response" do
      get daycare_documents_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_document_path(daycare.friendly_id, existing_document.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_document
      get daycare_document_path(daycare.friendly_id, existing_document.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_document
      get edit_daycare_document_path(daycare.friendly_id, existing_document.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new document" do
        expect {
          post daycare_documents_path(daycare.friendly_id), params: { document: attributes }
        }.to change(Document, :count).by(1)
      end

      it "redirects to the created document" do
        post daycare_documents_path(daycare.friendly_id), params: { document: attributes }
        expect(response.code).to eq "302"
      end
    end

    context "with invalid parameters" do
      let(:attaching_document) { nil }

      it "does not create a new document" do
        expect {
          post daycare_documents_path(daycare.friendly_id), params: { document: attributes }
        }.to change(Document, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_documents_path(daycare.friendly_id), params: { document: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { title: new_title } }
    
    before { existing_document }
    
    context "with valid parameters" do
      let(:new_title) { Faker::Lorem.unique.word }

      it "updates the requested document" do
        patch daycare_document_path(daycare.friendly_id, existing_document.id),
              params: { document: new_attributes }
        existing_document.reload
        expect(response.code).to eq "302"
      end

      it "redirects to the document" do
        patch daycare_document_path(daycare.friendly_id, existing_document.id),
              params: { document: new_attributes }
        expect(response).to redirect_to(daycare_document_path(daycare.friendly_id, existing_document.id))
      end
    end

    context "with invalid parameters" do
      let(:new_attributes) { { document: nil } }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_document_path(daycare.friendly_id, existing_document.id),
              params: { document: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "DELETE /destroy" do
    before { existing_document }

    it "destroys the requested document" do
      expect {
        delete daycare_document_path(daycare.friendly_id, existing_document.id)
      }.to change(Document, :count).by(-1)
    end

    it "redirects to the documents list" do
      delete daycare_document_path(daycare.friendly_id, existing_document.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
