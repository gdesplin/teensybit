require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/child_events", type: :request do
  let(:attributes) do 
    { 
      happened_at: happened_at,
      child_id: child.id
    } 
  end
  let(:happened_at) { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1) }
  let!(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:existing_child_event) { create(:child_event, child: child, user: current_user) }
  let(:child) { create(:child, daycare: daycare, users: [guardian]) }

  before do
    sign_in current_user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_child_event_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_child_event
      get daycare_child_event_path(daycare.friendly_id, existing_child_event.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_child_event
      get edit_daycare_child_event_path(daycare.friendly_id, existing_child_event.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new child_event" do
        expect {
          post daycare_child_events_path(daycare.friendly_id), params: { child_event: attributes }
        }.to change(ChildEvent, :count).by(1)
      end

      it "redirects to the created child_event" do
        post daycare_child_events_path(daycare.friendly_id), params: { child_event: attributes }
        expect(response.code).to redirect_to([:provider_dashboard, :daycares])
      end
    end

    context "with invalid parameters" do
      let(:happened_at) { nil }

      it "does not create a new child_event" do
        expect {
          post daycare_child_events_path(daycare.friendly_id), params: { child_event: attributes }
        }.to change(ChildEvent, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_child_events_path(daycare.friendly_id), params: { child_event: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { happened_at: new_happened_at } }
    
    before { existing_child_event }
    
    context "with valid parameters" do
      let(:new_happened_at) { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }

      it "updates the requested child_event" do
        patch daycare_child_event_path(daycare.friendly_id, existing_child_event.id),
              params: { child_event: new_attributes }
        existing_child_event.reload
        expect(response.code).to redirect_to([:provider_dashboard, :daycares])
      end

      it "redirects to the child_event" do
        patch daycare_child_event_path(daycare.friendly_id, existing_child_event.id),
              params: { child_event: new_attributes }
        expect(response).to redirect_to([:provider_dashboard, :daycares])
      end
    end

    context "with invalid parameters" do
      let(:new_happened_at) { "" }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_child_event_path(daycare.friendly_id, existing_child_event.id),
              params: { child_event: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "DELETE /destroy" do
    before { existing_child_event }

    it "destroys the requested child_event" do
      expect {
        delete daycare_child_event_path(daycare.friendly_id, existing_child_event.id)
      }.to change(ChildEvent, :count).by(-1)
    end

    it "redirects to the child_events list" do
      delete daycare_child_event_path(daycare.friendly_id, existing_child_event.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
