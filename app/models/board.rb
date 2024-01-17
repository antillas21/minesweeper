class Board < ApplicationRecord
  EMAIL_REGEX = /\A[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}\z/

  validates :name, presence: true, uniqueness: true
  validates :width, presence: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :mines_count, presence: true, numericality: { greater_than: 0 }
  validates :created_by, presence: true, format: { with: EMAIL_REGEX }

  scope :most_recent, -> { order(created_at: :desc).limit(10) }
  scope :by_name, ->(name) { where('name ILIKE ?', "%#{name}%") }
  scope :by_author, ->(email) { where('created_by ILIKE ?', "%#{email}%") }
  scope :by_min_mines, ->(count) { where('mines_count >= ?', count) }
end
