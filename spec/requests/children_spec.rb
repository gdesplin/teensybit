require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/children", type: :request do
  let(:attributes) do 
    { 
      name: name,
      user_ids: [guardian.id]
    } 
  end
  let(:name) { Faker::Name.name }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:existing_child) { create(:child, daycare: daycare, name: name, users: [guardian]) }

  before do
    sign_in current_user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_child_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_child
      get daycare_child_path(daycare.friendly_id, existing_child.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_child
      get edit_daycare_child_path(daycare.friendly_id, existing_child.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new child" do
        expect {
          post daycare_children_path(daycare.friendly_id), params: { child: attributes }
        }.to change(Child, :count).by(1)
      end

      it "redirects to the created child" do
        post daycare_children_path(daycare.friendly_id), params: { child: attributes }
        expect(response.code).to eq "302"
      end
    end

    context "with invalid parameters" do
      let(:name) { nil }

      it "does not create a new child" do
        expect {
          post daycare_children_path(daycare.friendly_id), params: { child: attributes }
        }.to change(Child, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_children_path(daycare.friendly_id), params: { child: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { name: new_name } }
    
    before { existing_child }
    
    context "with valid parameters" do
      let(:new_name) { Faker::Lorem.unique.name }

      it "updates the requested child" do
        patch daycare_child_path(daycare.friendly_id, existing_child.id),
              params: { child: new_attributes }
        existing_child.reload
        expect(response.code).to eq "302"
      end

      it "redirects to the child" do
        patch daycare_child_path(daycare.friendly_id, existing_child.id),
              params: { child: new_attributes }
        expect(response).to redirect_to([:provider_dashboard, :daycares])
      end
    end

    context "with invalid parameters" do
      let(:new_name) { "" }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_child_path(daycare.friendly_id, existing_child.id),
              params: { child: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "DELETE /destroy" do
    before { existing_child }

    it "destroys the requested child" do
      expect {
        delete daycare_child_path(daycare.friendly_id, existing_child.id)
      }.to change(Child, :count).by(-1)
    end

    it "redirects to the children list" do
      delete daycare_child_path(daycare.friendly_id, existing_child.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
