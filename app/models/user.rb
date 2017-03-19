class User < ApplicationRecord
  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
end
