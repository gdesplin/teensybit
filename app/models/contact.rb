
class Contact < ApplicationRecord
  enum source: {
    get_started: 0,
    email_signup: 1,
    feature: 2,
    free_trial: 3,
    monthly: 4,
    yearly: 5,
    message: 6,
  }
  validates :source, inclusion: { in: sources.keys }
  validates :email, presence: true
end
