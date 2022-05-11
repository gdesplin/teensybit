require "rails_helper"

RSpec.describe "/daycares/{daycare_id}/users", type: :request do
  let(:user) { create(:user, kind: :guardian, daycare: daycare) }
  let(:current_user) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: current_user.id) }


  before do
    sign_in current_user
  end

  describe "GET /show" do
    it "renders a successful response" do
      user
      get daycare_user_path(daycare.id, user.id)
      expect(response).to be_successful
    end
  end


  describe "DELETE /destroy" do
    before { user }

    it "destroys the requested user" do
      expect {
        delete daycare_user_path(daycare.id, user.id)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete daycare_user_path(daycare.id, user.id)
      expect(response.code).to redirect_to([:provider_dashboard, :daycares])
    end
  end
end
