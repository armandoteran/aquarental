class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show
    (record.owner == current_user) || (record.renter == current_user)
  end

  def create?
    true
  end

  def update?
    record.owner == current_user || record.renter == current_user
  end
end
