class Deck < ActiveRecord::Base
  scope :current_deck, -> { where(default: true) }

  has_many :cards, dependent: :destroy
  belongs_to :user
end
