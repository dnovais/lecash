require 'rails_helper'

RSpec.describe "Admin::Offers", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/offers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
