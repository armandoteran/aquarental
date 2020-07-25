class EquipmentsController < ApplicationController
  before_action :set_equipment, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # Authorization
  skip_after_action :verify_authorized, only: %i[index show]
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def index
    # binding.pry
    if current_user
      if params[:query].present?
        @equipments = policy_scope(Equipment).where(owner: current_user)
        @equipments = Equipment.search_by(params[:query])
      else
        @equipments = Equipment.all.where(owner: current_user)
        @equipments = policy_scope(Equipment)
      end
    else
      if params[:query].present?
        @equipments = policy_scope(Equipment)
        @equipments = Equipment.search_by(params[:query])
      else
        @equipments = Equipment.all
        @equipments = policy_scope(Equipment)
      end
    end
  end

  def show
    @booking = Booking.new
    # authorize @booking
    sqlq = "bookings.equipment_id = ?"
    @reviews = Review.joins(:booking).where(sqlq, params[:id])
  end

  def new
    @equipment = Equipment.new
    authorize @equipment
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.owner = current_user
    @equipment.state = 'UNPUBLISHED'
    authorize @equipment

    if @equipment.save
      redirect_to equipment_path(@equipment)
    else
      render :new
    end
  end

  def destroy
    authorize @equipment
    @equipment.destroy

    redirect_to equipments_path
  end

  def edit
    authorize @equipment
  end

  def update
    authorize @equipment
    @equipment.update(equipment_params)

    redirect_to equipment_path(@equipment)
  end

  def my
    @equipments = Equipment.where(user_id: current_user.id)
    authorize @equipments
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :category,
                                      :picture_url, :price_day, :price_hour,
                                      :start_date, :end_date, :location)
  end
end
