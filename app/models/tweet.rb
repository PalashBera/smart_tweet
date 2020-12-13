class Tweet < ApplicationRecord
  strip_attributes only: :message, collapse_spaces: true, replace_newlines: true

  belongs_to :user
  belongs_to :retweet, class_name: "Tweet", optional: true

  has_many :comments, dependent: :destroy
  has_many :retweets, class_name: "Tweet", foreign_key: :retweet_id

  delegate :initial,   to: :user, prefix: true
  delegate :full_name, to: :user, prefix: true

  validates :message, presence: true, length: { maximum: 250 }

  scope :decending, -> { order(created_at: :desc) }
  scope :search,    ->(query) { where("message LIKE ?", "%#{query}%") }

  def own_tweet?(current_user = nil)
    user == current_user
  end
end
