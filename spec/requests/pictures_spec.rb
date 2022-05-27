require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/pictures", type: :request do
  let(:attributes) do 
    { 
      title: title,
      description: Faker::Lorem.sentence,
      public_to_daycare: false,
      picture: attaching_picture,
      child_ids: [] 
    } 
  end
  let(:title) { Faker::Lorem.sentence }
  let(:attaching_picture) { Rack::Test::UploadedFile.new('spec/factories/files/test-picture.jpg', 'image/jpeg') }
  let(:provider) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let(:attached_picture) { Rack::Test::UploadedFile.new('spec/factories/files/test-picture-alt.jpg', 'image/jpeg') }
  let(:existing_picture) { create(:picture, daycare: daycare, user: provider, picture: attached_picture) }


  before do
    sign_in provider
  end

  describe "GET #index" do
    it "renders a successful response" do
      get daycare_pictures_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_picture_path(daycare.friendly_id, existing_picture.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_picture
      get daycare_picture_path(daycare.friendly_id, existing_picture.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_picture
      get edit_daycare_picture_path(daycare.friendly_id, existing_picture.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new picture" do
        expect {
          post daycare_pictures_path(daycare.friendly_id), params: { picture: attributes }
        }.to change(Picture, :count).by(1)
      end

      it "redirects to the created picture" do
        post daycare_pictures_path(daycare.friendly_id), params: { picture: attributes }
        expect(response.code).to eq "302"
      end
    end

    context "with invalid parameters" do
      let(:attaching_picture) { nil }

      it "does not create a new picture" do
        expect {
          post daycare_pictures_path(daycare.friendly_id), params: { picture: attributes }
        }.to change(Picture, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_pictures_path(daycare.friendly_id), params: { picture: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { title: new_title } }
    
    before { existing_picture }
    
    context "with valid parameters" do
      let(:new_title) { Faker::Lorem.unique.word }

      it "updates the requested picture" do
        patch daycare_picture_path(daycare.friendly_id, existing_picture.id),
              params: { picture: new_attributes }
        existing_picture.reload
        expect(response.code).to eq "302"
      end

      it "redirects to the picture" do
        patch daycare_picture_path(daycare.friendly_id, existing_picture.id),
              params: { picture: new_attributes }
        expect(response).to redirect_to(daycare_picture_path(daycare.friendly_id, existing_picture.id))
      end
    end

    context "with invalid parameters" do
      let(:new_attributes) { { picture: nil } }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_picture_path(daycare.friendly_id, existing_picture.id),
              params: { picture: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "DELETE /destroy" do
    before { existing_picture }

    it "destroys the requested picture" do
      expect {
        delete daycare_picture_path(daycare.friendly_id, existing_picture.id)
      }.to change(Picture, :count).by(-1)
    end

    it "redirects to the pictures list" do
      delete daycare_picture_path(daycare.friendly_id, existing_picture.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
