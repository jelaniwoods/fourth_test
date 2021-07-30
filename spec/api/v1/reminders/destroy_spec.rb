require "rails_helper"

RSpec.describe "reminders#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/reminders/#{reminder.id}"
  end

  describe "basic destroy" do
    let!(:reminder) { create(:reminder) }

    it "updates the resource" do
      expect(ReminderResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { Reminder.count }.by(-1)
      expect { reminder.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
