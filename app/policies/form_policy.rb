class FormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.owned_daycare&.forms.order(updated_at: :desc)
    end
  end

  def show?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
  end

  def edit?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
  end

  def update?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
  end

  def create?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
  end

  def new?
    user.provider? && user.owned_daycare.present? && user.owned_daycare == record.daycare
  end

  def destroy?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
  end
end
