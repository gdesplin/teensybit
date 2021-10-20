class Picture < ApplicationRecord
  belongs_to :daycare
  belongs_to :user
  has_and_belongs_to_many :children

  has_one_attached :picture
  validates :picture, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']

end
