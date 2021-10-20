class PicturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        user.owned_daycare&.pictures.order(updated_at: :desc)
      elsif user.guardian?
        user.pictures.order(updated_at: :desc)
      else
        nil
      end
    end
  end

  def show?
    if user.provider?
      record.daycare == user.owned_daycare
    elsif user.guardian?
      user.pictures.exists?(record.id)
    else
      false
    end
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
