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
    return false if record.guardian.blank?

    (record.guardian == user && record.provider == record.guardian.daycare.owner) ||
      (record.provider == user && record.provider == record.guardian.daycare.owner)
  end

  def permitted_attributes
    [:guardian_id]
  end
end
