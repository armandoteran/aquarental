class EquipmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    record.owner == current_user
  end

  def destroy?
    record.owner == current_user
  end
end
