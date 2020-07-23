class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    (record.owner == user) || (record.renter == user)
  end

  def create?
    record.owner != user
  end

  def update?; end

  # Owner only
  def accept?
    record.owner == user
  end

  def reject?
    record.owner == user
  end
  #############

  # Renter only
  def cancel?
    record.renter == user
  end
  #############

  def destroy?
    (record.owner == user) || (record.renter == user)
  end
end
