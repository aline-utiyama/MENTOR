class Mentor < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :mentor_tags, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :tags, through: :mentor_tags
  has_many :certifications, dependent: :destroy
  # has_one_attached :photo
  validates :title, :availability, :price, :description, presence: true

  include PgSearch::Model
  pg_search_scope :mentor_and_tag_search,
  against: [ :description, :title ],
  associated_against: {
    tags: [ :name ]
  },
  using: {
    tsearch: { prefix: true }
  }

  def average_rating
    return 0 if reviews.count.zero?
    reviews.sum { |review| review.rating } / reviews.count
  end

end
