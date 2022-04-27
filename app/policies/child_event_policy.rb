class ChildEventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        user.owned_daycare&.child_events.order(updated_at: :desc)
      elsif user.guardian?
        user.child_events.order(updated_at: :desc)
      else
        nil
      end
    end
  end

  def create?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.child.daycare
    elsif user.guardian?
      user.children.where(id: record.child_id).present?
    end
  end

  def new?
    if user.provider?
      user.owned_daycare.present?
    elsif user.guardian?
      user.daycare.present?
    end
  end

  def show?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.child.daycare
    elsif user.guardian?
      user.children.where(id: record.child_id).present?
    end
  end

  def edit?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.child.daycare
    elsif user.guardian?
      record.user_id == user.id
    end
  end
  
  def update?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.child.daycare
    elsif user.guardian?
      record.user_id == user.id
    end
  end

  def destroy?
    if user.provider?
      user.owned_daycare.present? && user.owned_daycare == record.child.daycare
    elsif user.guardian?
      record.user_id == user.id
    end
  end

end