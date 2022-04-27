class ChatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        user.as_provider_chats
      elsif user.guardian?
        user.as_guardian_chat
      else
        nil
      end
    end
  end

  def show?
    record.guardian == user || record.provider == user
  end

  def create?
    (record.guardian == user && record.provider == record.guardian.daycare.owner) ||
      (record.provider == user && record.provider == record.guardian.daycare.owner)
  end

  def permitted_attributes
    [:provider_id, :guardian_id]
  end
end
