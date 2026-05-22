class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :release_date, presence: true

  scope :search_by_name, -> (name) {
    where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name.present?
  }
  scope :filter_by_release_date, -> (date) {
    where(release_date: date) if date.present?
  }

  def average_rating
    reviews.average(:rating)&.round(2) || 0
  end
end