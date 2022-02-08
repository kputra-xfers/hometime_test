require 'rails_helper'

describe Reservation, type: :model do
  let!(:guest) { Guest.create(email: 'abc@xyz.com') }

  it "is not valid without code" do
    subject = described_class.new(guest_id: guest.id)
    expect(subject).not_to be_valid
  end

  it "is valid to have different code" do
    described_class.create(guest_id: guest.id, code: "ABC123")
    subject = described_class.new(guest_id: guest.id, code: "ABC456")

    expect(subject).to be_valid
  end

  it "is not valid to have same code" do
    described_class.create(guest_id: guest.id, code: "ABC123")
    subject = described_class.new(guest_id: guest.id, code: "ABC123")

    expect(subject).not_to be_valid
  end

  it "is valid start_date after today" do
    subject = described_class.create(guest_id: guest.id, code: "ABC123", start_date: "2030-01-01")
    expect(subject).to be_valid
  end

  it "is not valid start_date before today" do
    subject = described_class.create(guest_id: guest.id, code: "ABC123", start_date: "2021-01-01")
    expect(subject).not_to be_valid
  end

  it "is valid start_date before end_date" do
    subject = described_class.create(guest_id: guest.id, code: "ABC123", start_date: "2029-12-31", end_date: "2030-01-01")
    expect(subject).to be_valid
  end

  it "is not valid start_date after end_date" do
    subject = described_class.create(guest_id: guest.id, code: "ABC123", start_date: "2030-01-01", end_date: "2029-12-31")
    expect(subject).not_to be_valid
  end
end
