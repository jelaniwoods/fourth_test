require "rails_helper"

RSpec.describe "reminders#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/reminders/#{reminder.id}", payload
  end

  describe "basic update" do
    let!(:reminder) { create(:reminder) }

    let(:payload) do
      {
        data: {
          id: reminder.id.to_s,
          type: "reminders",
          attributes: {
            # ... your attrs here
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit "updates the resource" do
      expect(ReminderResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { reminder.reload.attributes }
    end
  end
end
