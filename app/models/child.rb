class Child < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :daycare

  validates :name, presence: true
end
