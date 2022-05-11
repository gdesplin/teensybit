class DaycareUserContextPolicy < ApplicationPolicy
  attr_reader :daycare, :record, :user

  class Scope

    def initialize(context, scope)
      @user  = context.user
      @daycare  = context.daycare
      @scope = scope
    end
  
    private
  
    attr_reader :daycare, :user, :scope
  
  end
  
  def initialize(context, record)
    super

    @user = context.user
    @daycare = context.daycare
    @record = record
  end
end
