# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
end
