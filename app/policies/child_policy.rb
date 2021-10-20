class ChildPolicy < ApplicationPolicy

  def create?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.daycare
    elsif user.guardian?
      user.daycare.present? && user.daycare == record.daycare
    else
      false
    end
  end

  def new?
    if user.provider?
      user.owned_daycare.present?
    elsif user.guardian?
      user.daycare.present? && user.daycare == record.daycare
    else
      false
    end
  end

  def show?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.daycare
    elsif user.guardian?
      record.users.where(id: user.id).present?
    else
      false
    end
  end

  def edit?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.daycare
    elsif user.guardian?
      record.users.where(id: user.id).present?
    else
      false
    end
  end
  
  def update?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.daycare
    elsif user.guardian?
      record.users.where(id: user.id).present?
    else
      false
    end
  end

  def destroy?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.daycare
    elsif user.guardian?
      record.users.where(id: user.id).present?
    else
      false
    end
  end

end