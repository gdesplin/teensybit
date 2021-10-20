class Picture < ApplicationRecord
  belongs_to :daycare
  belongs_to :user
  has_and_belongs_to_many :children

  has_one_attached :picture
  validates :picture, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']

  after_save :message_parents

  private

  def message_parents
    children.each do |child|
      child.users.each do |parent|
        MessagePictureJob.perform_later(id, parent.email, child.name)
      end
    end
  end

end
