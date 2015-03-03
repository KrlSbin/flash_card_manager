class Deck < ActiveRecord::Base
  scope :current_deck, -> { where(default: true) }

  has_many :cards, dependent: :destroy
  belongs_to :user

  validates :default, uniqueness: { scope: :user_id }, if: :default_is_true?

  def default_is_true?
    default == true
  end
end
