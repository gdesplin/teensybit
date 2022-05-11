require "rails_helper"

RSpec.describe "/daycares", type: :request do
  let(:attributes) do 
    { 
      name: name,
      user_ids: [provider.id]
    } 
  end
  let(:name) { Faker::Company.name }
  let(:provider) { create(:user, kind: :provider) }
  let(:current_user) { create(:user, kind: :provider) }
  let(:guardian) { create(:user, kind: :guardian, daycare: existing_daycare) }
  let!(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:existing_daycare) { create(:daycare, name: name, owner: provider) }

  before do
    sign_in current_user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_path
      expect(response).to be_successful
    end
  end

  describe "GET /provider_dashboard" do
    it "renders a successful response" do
      existing_daycare
      get provider_dashboard_daycares_path(existing_daycare.id)
      expect(response).to be_successful
    end
  end


  describe "GET /guardian_dashboard" do
    before do
      sign_in guardian
    end
    it "renders a successful response" do
      existing_daycare
      get guardian_dashboard_daycares_path(existing_daycare.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_daycare
      get edit_daycare_path(existing_daycare.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new daycare" do
        expect {
          post daycares_path, params: { daycare: attributes }
        }.to change(Daycare, :count).by(1)
      end

      it "redirects to the created daycare" do
        post daycares_path, params: { daycare: attributes }
        expect(response.code).to eq "302"
      end
    end

    context "with invalid parameters" do
      let(:name) { nil }

      it "does not create a new daycare" do
        expect {
          post daycares_path, params: { daycare: attributes }
        }.to change(Daycare, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycares_path, params: { daycare: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { name: new_name } }
    
    before { existing_daycare }
    
    context "with valid parameters" do
      let(:new_name) { Faker::Company.unique.name }

      it "updates the requested daycare" do
        patch daycare_path(existing_daycare.id),
              params: { daycare: new_attributes }
        existing_daycare.reload
        expect(response.code).to eq "302"
      end

      it "redirects to the daycare" do
        patch daycare_path(existing_daycare.id),
              params: { daycare: new_attributes }
        expect(response).to redirect_to(action: :provider_dashboard, notice: "Daycare successfully updated")
      end
    end

    context "with invalid parameters" do
      let(:new_name) { "" }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_path(existing_daycare.id),
              params: { daycare: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end
end
