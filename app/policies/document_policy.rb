class DocumentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        user.owned_daycare&.documents.order(updated_at: :desc)
      elsif user.guardian?
        user.viewable_documents.order(updated_at: :desc)
      else
        nil
      end
    end
  end

  def permitted_attributes
    if user.provider?
      [:title, :description, :public_to_daycare, :document, user_ids: []]
    elsif user.guardian?
      [:response_document]
    end
  end

  def show?
    if user.provider?
      record.daycare == user.owned_daycare
    elsif user.guardian?
      user.viewable_documents.exists?(record.id)
    else
      false
    end
  end

  def edit?
    if user.provider?
      record.daycare == user.owned_daycare
    elsif user.guardian?
      user.viewable_documents.exists?(record.id)
    else
      false
    end
  end

  def update?
    if user.provider?
      record.daycare == user.owned_daycare
    elsif user.guardian?
      user.viewable_documents.exists?(record.id)
    else
      false
    end
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
