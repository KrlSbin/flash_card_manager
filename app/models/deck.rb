class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user
end
