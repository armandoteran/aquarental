class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @equipment = Equipment.find(params[:equipment_id])
    @booking = Booking.new
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @booking = Booking.new(booking_params)
    @booking.renter = current_user
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
