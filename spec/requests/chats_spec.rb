require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/chats", type: :request do
  let(:attributes) do 
    { 
      guardian_id: guardian_id
    } 
  end
  let(:guardian_id) { guardian.id }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:existing_chat) { create(:chat, provider: current_user, guardian: guardian) }

  before do
    sign_in current_user
  end

  describe "GET /show" do
    it "renders a successful response" do
      existing_chat
      get daycare_chat_path(daycare.friendly_id, existing_chat.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new chat" do
        expect {
          post daycare_chats_path(daycare.friendly_id), params: { chat: attributes }
        }.to change(Chat, :count).by(1)
      end

      it "redirects to the created chat" do
        post daycare_chats_path(daycare.friendly_id), params: { chat: attributes }
        expect(response.code).to eq "302"
      end
    end

    context "with invalid parameters" do
      let(:guardian_id) { nil }

      it "does not create a new chat" do
        expect {
          post daycare_chats_path(daycare.friendly_id), params: { chat: attributes }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
