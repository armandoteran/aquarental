class EquipmentsController < ApplicationController
  before_action :set_equipment, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # Authorization
  skip_after_action :verify_authorized, only: %i[index show]
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def index
    if params[:query].present?
      @equipments = policy_scope(Equipment)
      @equipments = Equipment.search_by(params[:query])
    else
      @equipments = Equipment.all
      @equipments = policy_scope(Equipment)
    end
  end

  def show
    @booking = Booking.new
    #authorize @booking
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
    @equipment = Equipment.find(params[:id])
  end

  def update
    authorize @equipment
    @equipment.update(equipment_params)

    redirect_to equipment_path(@equipment)
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
