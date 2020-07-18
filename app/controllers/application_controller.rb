class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: %i[equipment equipments root home]

end
