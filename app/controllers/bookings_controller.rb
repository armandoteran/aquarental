class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show accept reject cancel]
  # Authorization
  skip_after_action :verify_authorized, only: %i[index]
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def index
    @as_renter_bookings = Booking.where(renter: current_user)
    # Extranamente la relacion Booking.owner funciona en consola pero no aqui
    # @as_owner_bookings = Booking.where(owner: current_user)
    sqlq = "equipment.user_id = ?"
    @as_owner_bookings = Booking.joins(:equipment).where(sqlq, current_user.id)
    # provisorio
    # binding.pry
  end

  def show
    authorize @booking
  end

  def new
    @equipment = Equipment.find(params[:equipment_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @booking = Booking.new(booking_params)
    @booking.equipment = @equipment
    @booking.renter = current_user
    @booking.state = 'PENDING'
    authorize @booking
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  # Owner only
  def accept
    @booking.state = 'BOOKED'
    @booking.save
    authorize @booking
    redirect_to bookings_path
  end

  def reject
    @booking.state = 'REJECTED'
    @booking.save
    authorize @booking
    redirect_to bookings_path
  end
  ######################################

  # Renter only
  def cancel
    @booking.state = 'CANCELLED'
    @booking.save
    authorize @booking
    redirect_to bookings_path
  end
  #############

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
