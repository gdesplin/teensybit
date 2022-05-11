class DaycareUserContext
  attr_reader :user, :daycare

  def initialize(user, daycare)
    @user = user
    @daycare = daycare
  end
end
