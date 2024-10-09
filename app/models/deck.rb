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
# Indexes
#
#  index_decks_on_user_id  (user_id)
#

class Deck < ActiveRecord::Base
  validates_presence_of :name

  has_many :cards, class_name: 'Card', foreign_key: :deck_id, dependent: :destroy
  belongs_to :user
end
