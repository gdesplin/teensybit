class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        user.messages.where(recipient_id: params[:recipient_id])
          .or.recieved_messages.where(user_id: params[:recipient_id])
          .order(created_at: :desc)
      elsif user.guardian?
        user.recieved_messages.or.messages.order(created_at: :desc)
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
