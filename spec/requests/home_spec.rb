require "rails_helper"

RSpec.describe "/", type: :request do
  describe "GET /" do
    it "renders a successful response" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "GET /terms" do
    it "renders a successful response" do
      get terms_path
      expect(response).to be_successful
    end
  end

  describe "GET /privacy_policy" do
    it "renders a successful response" do
      get privacy_policy_path
      expect(response).to be_successful
    end
  end

  describe "GET /check_email" do
    it "renders a successful response" do
      get check_email_path
      expect(response).to be_successful
    end
  end
end