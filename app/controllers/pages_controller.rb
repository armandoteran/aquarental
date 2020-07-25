class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    if current_user
      @equipments = Equipment.all.where.not(owner: current_user).sample(3)
    else
      @equipments = Equipment.all.sample(3)
    end
  end
end
