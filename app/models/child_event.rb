class ChildEvent < ApplicationRecord
  belongs_to :child
  belongs_to :user

  after_save :message_user

  private

  def message_user
    MessageChildEventJob.perform_later(id, user.email)
  end
end
