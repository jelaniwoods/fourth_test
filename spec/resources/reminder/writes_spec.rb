require "rails_helper"

RSpec.describe ReminderResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "reminders",
          attributes: {},
        },
      }
    end

    let(:instance) do
      ReminderResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { Reminder.count }.by(1)
    end
  end

  describe "updating" do
    let!(:reminder) { create(:reminder) }

    let(:payload) do
      {
        data: {
          id: reminder.id.to_s,
          type: "reminders",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      ReminderResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { reminder.reload.updated_at }
      # .and change { reminder.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:reminder) { create(:reminder) }

    let(:instance) do
      ReminderResource.find(id: reminder.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { Reminder.count }.by(-1)
    end
  end
end
