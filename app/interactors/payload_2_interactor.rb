class Payload2Interactor < BaseInteractor
  def call
    set_guest
    upsert_reservation
  end

  private

  def set_guest
    @guest = Guest.find_by(email: context.params[:guest_email])
    create_guest unless @guest
  end

  def create_guest
    @guest = Guest.create!(
      email: context.params[:guest_email],
      first_name: context.params[:guest_first_name],
      last_name: context.params[:guest_last_name],
      phone_number: context.params[:guest_phone_numbers].to_json,
    )
  end

  def upsert_reservation
    @reservation = @guest.reservations.find_by(code: context.params[:code])
    
    if @reservation
      update_reservation
    else
      create_reservation
    end
  end

  def update_reservation
    @reservation.update!(
      start_date: context.params[:start_date],
      end_date: context.params[:end_date],
      nights: context.params[:nights],
      guests: context.params[:number_of_guests],
      adults: context.params[:guest_details][:number_of_adults],
      children: context.params[:guest_details][:number_of_children],
      infants: context.params[:guest_details][:number_of_infants],
      status: context.params[:status_type],
      currency: context.params[:host_currency],
      payout_price: context.params[:expected_payout_amount],
      security_price: context.params[:listing_security_price_accurate],
      total_price: context.params[:total_paid_amount_accurate],
    )
  end

  def create_reservation
    @guest.reservations.create!(
      code: context.params[:code],
      start_date: context.params[:start_date],
      end_date: context.params[:end_date],
      nights: context.params[:nights],
      guests: context.params[:number_of_guests],
      adults: context.params[:guest_details][:number_of_adults],
      children: context.params[:guest_details][:number_of_children],
      infants: context.params[:guest_details][:number_of_infants],
      status: context.params[:status_type],
      currency: context.params[:host_currency],
      payout_price: context.params[:expected_payout_amount],
      security_price: context.params[:listing_security_price_accurate],
      total_price: context.params[:total_paid_amount_accurate],
    )
  end
end
