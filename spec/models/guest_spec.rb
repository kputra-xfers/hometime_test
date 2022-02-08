require 'rails_helper'

describe Guest, type: :model do
  it "is not valid without email" do
    subject = described_class.new()
    expect(subject).not_to be_valid
  end

  it "is valid to have different email" do
    described_class.create(email: 'abc@xyz.com')
    subject = described_class.new(email: 'xyz@abc.com')

    expect(subject).to be_valid
  end

  it "is not valid to have same email" do
    described_class.create(email: 'abc@xyz.com')
    subject = described_class.new(email: 'abc@xyz.com')

    expect(subject).not_to be_valid
  end
end
