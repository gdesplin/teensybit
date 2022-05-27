require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/broadcast_messages", type: :request do
  let(:attributes) do 
    { 
      message_body: message_body,
      recipient_ids: [guardian.id]
    } 
  end
  let(:message_body) { Faker::Lorem.sentence }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:provider) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }

  before do
    sign_in provider
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_daycare_broadcast_message_path(daycare.friendly_id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new broadcast_message" do
        expect {
          post daycare_broadcast_messages_path(daycare.friendly_id), params: { broadcast_message: attributes }
        }.to change(Message, :count).by(1)
      end

      it "redirects to the created broadcast_message" do
        post daycare_broadcast_messages_path(daycare.friendly_id), params: { broadcast_message: attributes }
        expect(response.code).to eq "302"
      end
    end

    context "with invalid parameters" do
      let(:message_body) { "" }

      it "does not create a new broadcast_message" do
        expect {
          post daycare_broadcast_messages_path(daycare.friendly_id), params: { broadcast_message: attributes }
        }.to change(Message, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_broadcast_messages_path(daycare.friendly_id), params: { broadcast_message: attributes }
        expect(response.code).to eq "422"
      end
    end
  end
end
