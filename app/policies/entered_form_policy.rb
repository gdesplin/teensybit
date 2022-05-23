class EnteredFormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.provider?
        user.owned_daycare&.entered_forms.order(updated_at: :desc)
      elsif user.guardian?
        user.entered_forms.order(updated_at: :desc)
      else
        nil
      end
    end
  end

  def permitted_attributes
    [
      :form_id,
      entered_form_fields_attributes: [
        :attachment,
        :id,
        :entered_date,
        :entered_datetime,
        :entered_form_id,
        :entered_string,
        :entered_text,
        :entered_time,
        :form_field_id,
        entered_array: []
      ]
    ]
  end

  def show?
    if user.provider?
      record.daycare == user.owned_daycare
    elsif user.guardian?
      record.user == user
    end
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def create?
    return false unless user.guardian?

    user.viewable_forms.exists?(record.form&.id)
  end

  def new?
    return false unless user.guardian?

    user.viewable_forms.exists?(record.form.id)
  end

  def destroy?
    user.provider? && user.owned_daycare.present? && record.daycare == user.owned_daycare
  end
end
