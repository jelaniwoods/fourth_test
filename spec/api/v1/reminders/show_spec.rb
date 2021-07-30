require "rails_helper"

RSpec.describe "reminders#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/reminders/#{reminder.id}", params: params
  end

  describe "basic fetch" do
    let!(:reminder) { create(:reminder) }

    it "works" do
      expect(ReminderResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("reminders")
      expect(d.id).to eq(reminder.id)
    end
  end
end
