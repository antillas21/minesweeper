class Board < ApplicationRecord
  EMAIL_REGEX = /\A[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}\z/

  validates :name, presence: true
  validates :width, presence: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :mines_count, presence: true, numericality: { greater_than: 0 }
  validates :created_by, presence: true, format: { with: EMAIL_REGEX }
end
