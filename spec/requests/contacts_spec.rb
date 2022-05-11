require "rails_helper"

RSpec.describe "/contacts", type: :request do
  let(:attributes) do 
    { 
      email: email,
      source: "get_started"
    } 
  end

  let(:email) { Faker::Internet.email }

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new contact" do
        expect {
          post contacts_path, params: { contact: attributes }
        }.to change(Contact, :count).by(1)
      end

      it "redirects to the created contact" do
        post contacts_path, params: { contact: attributes }
        expect(response.code).to redirect_to(:root)
      end
    end

    context "with invalid parameters" do
      let(:email) { nil }

      it "does not create a new contact" do
        expect {
          post contacts_path, params: { contact: attributes }
        }.to change(Contact, :count).by(0)
      end
    end
  end
end
