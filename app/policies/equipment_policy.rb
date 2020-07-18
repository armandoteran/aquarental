class EquipmentPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      scope.all
    end



  end
end
