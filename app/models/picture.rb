class Picture < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {maximum: 30}
  validates :filename, presence: true
end
