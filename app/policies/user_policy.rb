class UserPolicy < ApplicationPolicy

  def destroy?
    user.owned_daycare.present? && user.owned_daycare == record.daycare
  end

  def show?
    user.owned_daycare.present? && user.owned_daycare == record.daycare
  end
end