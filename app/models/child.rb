class Child < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :pictures

  has_many :child_events

  belongs_to :daycare

  validates :name, presence: true
  validates_presence_of :users

  has_one_attached :photo

end
