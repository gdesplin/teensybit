class DaycarePolicy < ApplicationPolicy

  def edit?
    user.owned_daycare == record
  end
  
  def update?
    user.owned_daycare == record
  end

  def provider_dashboard?
    user.owned_daycare == record
  end

  def guardian_dashboard?
    user.guardian? && user.daycare == record
  end
end