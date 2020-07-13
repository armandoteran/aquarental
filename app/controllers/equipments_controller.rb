class EquipmentsController < ApplicationController
  before_action :set_equipment, only: %i[show destroy]

  def index
    @equipments = Equipment.all
  end

  def show
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.user = current_user
    @equipment.state = 'pending'

    if @equipment.save
      redirect_to equipment_path(@equipment)
    else
      render :new
    end
  end

  def destroy
    @equipment.destroy

    redirect_to equipments_path
  end

  private

  def set_equpiment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :category,
                                      :picture_url, :price_day, :price_hour,
                                      :start_date, :end_date, :location)
  end
end
