require 'rails_helper'

describe Payload1Interactor do
  let!(:params) do
    {
      reservation_code: "YYY12345678",
      start_date: "2021-04-14",
      end_date: "2021-04-18",
      nights: 4,
      guests: 4,
      adults: 2,
      children: 2,
      infants: 0,
      status: "accepted",
      guest: {
          first_name: "Wayne",
          last_name: "Woodbridge",
          phone: "639123456789",
          email: "wayne_woodbridge@bnb.com",
      },
      currency: "AUD",
      payout_price: "4200.00",
      security_price: "500",
      total_price: "4700.00",
    }
  end

  context "when positive case" do
    context "when the guest is new" do
      context "when the reservation is new" do
        it "creates a guest and the reservation" do
          expect do
            described_class.call(params: params)
          end.to change(Guest, :count).by(1)
            .and change(Reservation, :count).by(1)
        end
      end
    end

    context "when the guest already exists" do
      context "when the reservation is new" do
        before do
          Guest.create(
            first_name: "Wayne",
            last_name: "Woodbridge",
            phone_number: "639123456789",
            email: "wayne_woodbridge@bnb.com"
          )
        end

        it "doesnt create guest" do
          expect do
            described_class.call(params: params)
          end.not_to change(Guest, :count)
        end

        it "creates new reservation" do
          expect do
            described_class.call(params: params)
          end.to change(Reservation, :count).by(1)
        end
      end

      context "when the reservation is already exists" do
        before do
          guest = Guest.create(
            first_name: "Wayne",
            last_name: "Woodbridge",
            phone_number: "639123456789",
            email: "wayne_woodbridge@bnb.com"
          )

          guest.reservations.create(
            code: "YYY12345678",
            start_date: "2021-04-14",
            end_date: "2021-04-18",
            nights: 5,
            guests: 5,
            adults: 2,
            children: 2,
            infants: 0,
            status: "accepted",
            currency: "AUD",
            payout_price: "4200.00",
            security_price: "500",
            total_price: "4700.00"
          )
        end

        it "doesnt create new reservation" do
          expect do
            described_class.call(params: params)
          end.not_to change(Reservation, :count)
        end

        it "updates the existing reservation" do
          described_class.call(params: params)

          reservation = Reservation.last
          expect(reservation.nights).to eq(4)
          expect(reservation.guests).to eq(4)
        end
      end
    end
  end
end
