class StripePricePolicy < ApplicationPolicy

  def create?
    user.owned_daycare.present? && user.owned_daycare == record.stripe_product&.stripe_account&.daycare
  end

  def new?
    user.owned_daycare.present? && user.owned_daycare == record.stripe_product&.stripe_account&.daycare
  end

  def destroy?
    user.owned_daycare.present? && user.owned_daycare == record.stripe_product&.stripe_account&.daycare
  end
end