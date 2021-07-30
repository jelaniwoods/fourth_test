require "rails_helper"

RSpec.describe ReminderResource, type: :resource do
  describe "serialization" do
    let!(:reminder) { create(:reminder) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(reminder.id)
      expect(data.jsonapi_type).to eq("reminders")
    end
  end

  describe "filtering" do
    let!(:reminder1) { create(:reminder) }
    let!(:reminder2) { create(:reminder) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: reminder2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([reminder2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:reminder1) { create(:reminder) }
      let!(:reminder2) { create(:reminder) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      reminder1.id,
                                      reminder2.id,
                                    ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      reminder2.id,
                                      reminder1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
