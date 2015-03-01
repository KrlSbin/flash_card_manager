class Deck < ActiveRecord::Base
  scope :current_deck, -> { where(default: true) }

  has_many :cards, dependent: :destroy
  belongs_to :user

  validate :only_one_current

  def only_one_current
    if default? and Deck.current_deck.all.any? and id != Deck.current_deck.first.id
      errors.add(:default, " card deck already exists!")
    end
  end
end
