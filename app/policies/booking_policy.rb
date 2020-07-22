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
    true
  end

  def update?
    record.owner == user
  end

  def destroy?
    (record.owner == user) || (record.renter == user)
  end
end
