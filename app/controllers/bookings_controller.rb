class BookingsController < ApplicationController
  # Authorization
  skip_after_action :verify_authorized, only: %i[index]
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def index
    user_equipments = Equipment.where(user_id: current_user.id)
    @bookings = Booking.all
    user_equipments.each do |equipment|
      @bookings.each do |booking|
        if booking.equipment_id == equipment.id
          @as_owner_bookings = Booking.where(equipment_id: equipment.id)
        end
      end
    end
    @as_renter_bookings = Booking.where(renter: current_user.id)
    # provisorio
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
    @as_renter_booking = Booking.find(params[:id])
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
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
