class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :release_date, presence: true

  scope :search_by_name, ->(name) {
    name.present? ? where("LOWER(name) LIKE ?", "%#{name.downcase}%") : all
  }

  scope :filter_by_release_date, ->(date) {
    date.present? ? where(release_date: date) : all
  }
  def average_rating
    reviews.average(:rating)&.round(2) || 0
  end
end
