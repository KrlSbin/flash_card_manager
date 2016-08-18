# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string
#  crypted_password :string
#  created_at       :datetime
#  updated_at       :datetime
#  salt             :string
#  current_deck_id  :integer
#

require "rails_helper"

describe User do
  it "do not save instance with less than 3 symbols in password" do
    user = User.new(email: "123", password: "12", password_confirmation: "12")
    expect(user.valid?).to be false
  end

  it "do not save instance with alredy used email" do
    User.create(email: "123", password: "123", password_confirmation: "123")
    user = User.new(email: "123", password: "321", password_confirmation: "321")
    expect(user.valid?).to be false
  end

  it "do not save instance without password" do
    user = User.new(email: "123", password_confirmation: "321")
    expect(user.valid?).to be false
  end

  it "do not save instance without confirmation" do
    user = User.new(email: "123", password: "321")
    expect(user.valid?).to be false
  end

  it "do not save instance with wrong confirmation" do
    user = User.new(email: "123", password: "321", password_confirmation: "322")
    expect(user.valid?).to be false
  end
end
