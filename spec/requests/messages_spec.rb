require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/messages", type: :request do
  let(:attributes) do 
    { 
      message_body: message_body,
      recipient_id: guardian.id,
      chat_id: chat.id
    } 
  end
  let(:message_body) { Faker::Lorem.sentence }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: current_user.id) }
  let(:chat) { create(:chat, guardian: guardian, provider: current_user) }
  let(:existing_message) { create(:message, user: current_user, recipient: guardian, chat: chat, message_body: message_body) }

  before do
    sign_in current_user
  end

  describe "GET /edit" do
    it "render a successful response" do
      existing_message
      get edit_daycare_chat_message_path(daycare.id, chat.id, existing_message.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new message" do
        expect {
          post daycare_chat_messages_path(daycare.id, chat.id), params: { message: attributes }
        }.to change(Message, :count).by(1)
      end

      it "redirects to the created message" do
        post daycare_chat_messages_path(daycare.id, chat.id), params: { message: attributes }
        expect(response.code).to eq "200"
      end
    end

    context "with invalid parameters" do
      let(:message_body) { nil }

      it "does not create a new message" do
        expect {
          post daycare_chat_messages_path(daycare.id, chat.id), params: { message: attributes }
        }.to change(Message, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post daycare_chat_messages_path(daycare.id, chat.id), params: { message: attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { message_body: new_message_body } }
    
    before { existing_message }
    
    context "with valid parameters" do
      let(:new_message_body) { Faker::Lorem.unique.sentence }

      it "updates the requested message" do
        patch daycare_chat_message_path(daycare.id, chat.id, existing_message.id),
              params: { message: new_attributes }
        existing_message.reload
        expect(existing_message.message_body).to eq new_message_body
      end

      it "redirects to the message" do
        patch daycare_chat_message_path(daycare.id, chat.id, existing_message.id),
              params: { message: new_attributes }
        expect(response.media_type).to eq Mime[:turbo_stream]
      end
    end

    context "with invalid parameters" do
      let(:new_message_body) { "" }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch daycare_chat_message_path(daycare.id, chat.id, existing_message.id),
              params: { message: new_attributes }
        expect(response.code).to eq "422"
      end
    end
  end

  describe "PATCH /mark_as_read" do
    before do
      existing_message
      sign_in guardian
    end
    context "with valid parameters" do
      it "updates the requested message" do
        patch mark_as_read_daycare_chat_message_url(daycare.id, chat.id, existing_message.id)
        existing_message.reload
        expect(existing_message.recipient_read_at).not_to be_blank
      end
    end
  end
end
