class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    @equipments = Equipment.all.sample(3)
  end
end
