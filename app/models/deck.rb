# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          indexed
#
# Indexes
#
#  index_decks_on_user_id  (user_id)
#

class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
end
