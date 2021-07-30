require "rails_helper"

RSpec.describe "reminders#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/reminders", params: params
  end

  describe "basic fetch" do
    let!(:reminder1) { create(:reminder) }
    let!(:reminder2) { create(:reminder) }

    it "works" do
      expect(ReminderResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["reminders"])
      expect(d.map(&:id)).to match_array([reminder1.id, reminder2.id])
    end
  end
end
