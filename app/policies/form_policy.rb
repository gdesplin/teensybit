class FormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.owned_daycare&.forms
    end
  end

  def show?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
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

  def permitted_attributes
    [
      :title,
      :description,
      :published_to_daycare,
      form_fields_attributes: [
        :id,
        :_destroy,
        :form_id,
        :question,
        :description,
        :position,
        :required,
        :field_kind,
        form_field_options_attributes: [:id, :_destroy, :name, :position]
      ],
      user_ids: []
    ]
  end
end
