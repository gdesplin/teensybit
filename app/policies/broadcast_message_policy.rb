class BroadcastMessagePolicy < ApplicationPolicy
  def create?
    user.provider? && user.owned_daycare.present?
  end

  def new?
    user.provider? && user.owned_daycare.present?
  end

  def permitted_attributes
    [:message_body, recipient_ids: []]
  end
end
