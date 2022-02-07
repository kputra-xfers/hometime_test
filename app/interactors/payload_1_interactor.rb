class Payload1Interactor < BaseInteractor
  def call
    set_guest
    upsert_reservation
  end

  private

  def set_guest
    @guest = Guest.find_by(email: context.params[:guest][:email])
    create_guest unless @guest
  end

  def create_guest
    @guest = Guest.create!(
      email: context.params[:guest][:email],
      first_name: context.params[:guest][:first_name],
      last_name: context.params[:guest][:last_name],
      phone_number: context.params[:guest][:phone],
    )
  end

  def upsert_reservation
    @reservation = @guest.reservations.find_by(code: context.params[:reservation_code])
    
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
      guests: context.params[:guests],
      adults: context.params[:adults],
      children: context.params[:children],
      infants: context.params[:infants],
      status: context.params[:status],
      currency: context.params[:currency],
      payout_price: context.params[:payout_price],
      security_price: context.params[:security_price],
      total_price: context.params[:total_price],
    )
  end

  def create_reservation
    @guest.reservations.create!(
      code: context.params[:reservation_code],
      start_date: context.params[:start_date],
      end_date: context.params[:end_date],
      nights: context.params[:nights],
      guests: context.params[:guests],
      adults: context.params[:adults],
      children: context.params[:children],
      infants: context.params[:infants],
      status: context.params[:status],
      currency: context.params[:currency],
      payout_price: context.params[:payout_price],
      security_price: context.params[:security_price],
      total_price: context.params[:total_price],
    )
  end
end
