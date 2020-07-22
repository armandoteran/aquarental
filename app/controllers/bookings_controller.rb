class BookingsController < ApplicationController
  # Authorization
  skip_after_action :verify_authorized, only: %i[index]
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def index
    @as_renter_bookings = Booking.where(renter: current_user)
    # Extranamente la relacion Booking.owner funciona en consola pero no aqui
    # @as_owner_bookings = Booking.where(owner: current_user)
    @as_owner_bookings = Booking.joins(:equipment).where(user_id: current_user.id)
    # provisorio
    # binding.pry
  end

  def show
    @booking = Booking.find(params[:id])
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

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    authorize @booking
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    authorize @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
