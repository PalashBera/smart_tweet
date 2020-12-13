class Comment < ApplicationRecord
  strip_attributes only: :message, collapse_spaces: true, replace_newlines: true

  belongs_to :user
  belongs_to :tweet

  delegate :initial,   to: :user, prefix: true
  delegate :full_name, to: :user, prefix: true

  validates :message, presence: true, length: { maximum: 250 }

  scope :decending, -> { order(created_at: :desc) }

  def own_comment?(current_user = nil)
    user == current_user
  end
end
