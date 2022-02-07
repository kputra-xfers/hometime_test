require 'rails_helper'

describe V1::Webhooks::ReservationsController, type: :request do
  let!(:base_url) { "/v1/webhooks/reservations" }

  describe "#create" do
    it "gives correct response body when success" do
      params = {
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
            email: "wayne_woodbridge@bnb.com"
        },
        currency: "AUD",
        payout_price: "4200.00",
        security_price: "500",
        total_price: "4700.00",
      }

      post base_url, params: params, as: :json
      res = JSON.parse(response.body)

      expect(response.code).to eq("200")
      expect(res["status"]).to eq("OK")
      expect(res["message"]).to eq("success")
    end

    it "calls Payload1Interactor" do
      params = {
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
            email: "wayne_woodbridge@bnb.com"
        },
        currency: "AUD",
        payout_price: "4200.00",
        security_price: "500",
        total_price: "4700.00",
      }
      allow_any_instance_of(Payload1Interactor).to receive(:call)

      post base_url, params: params, as: :json
    end

    it "calls Payload2Interactor" do
      params = {
        reservations: {
          code: "XXX12345678",
          start_date: "2021-03-12",
          end_date: "2021-03-16",
          expected_payout_amount: "3800.00",
          guest_details: {
            localized_description: "4 guests",
            number_of_adults: 2,
            number_of_children: 2,
            number_of_infants: 0
          },
          guest_email: "wayne_woodbridge@bnb.com",
          guest_first_name: "Wayne",
          guest_last_name: "Woodbridge",
          guest_phone_numbers: [
            "639123456789",
            "639123456789"
          ],
          listing_security_price_accurate: "500.00",
          host_currency: "AUD",
          nights: 4,
          number_of_guests: 4,
          status_type: "accepted",
          total_paid_amount_accurate: "4300.00",
        }
      }

      allow_any_instance_of(Payload2Interactor).to receive(:call)

      post base_url, params: params, as: :json
    end
  end
end
