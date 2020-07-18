class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  #provisorio
  def index
    true
  end

  def show
    record.owner == current_tuser || record.renter == current_user
  end

  def create?
    true
  end

  def update?
    record.owner == current_tuser || record.renter == current_user
  end
end
