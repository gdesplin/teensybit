class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        Message.where(chat_id: user.as_provider_chats.pluck(:id))
      elsif user.guardian?
        user.as_guardian_chat.messages
      else
        nil
      end
    end
  end

  def show?
    record.user == user || record.recipient == user
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def mark_as_read?
    record.recipient == user
  end

  def create?
    if user.provider? && user.owned_daycare.present?
      return record.recipient.daycare == user.owned_daycare
    elsif user.guardian?
      return record.recipient.owned_daycare == user.daycare
    else
      nil
    end
  end

  def new?
    return if user.provider? && user.owned_daycare.present? || user.guardian?
  end

  def permitted_attributes_for_create
    [:message_body, :recipient_id, :chat_id]
  end

  def permitted_attributes_for_update
    [:message_body]
  end
end
