require "rails_helper"

describe Card do
  it "not save instance with identical original and translated text fields" do
    card = Card.new(original_text: "Word", translated_text: "Word")
    expect(card.valid?).to be false
  end

  it "save instance with different original and translated text fields" do
    card = Card.new(original_text: "Word", translated_text: "Слово")
    expect(card.save).to be true
  end

  it "check positive translation" do
    card = Card.create(original_text: "Word", translated_text: "Слово")

    expect(card.check_translation("Слово")).to be true
  end

  it "check negative translation" do
    card = Card.create(original_text: "Word", translated_text: "Слово")

    expect(card.check_translation("Словечки")).to be false
  end

  it "update review date if translation is correct" do
    card = Card.create(original_text: "Word", translated_text: "Слово")
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date).to eql(original_review_date + 3.day)
  end

  it "not update review date if translation is not correct" do
    card = Card.create(original_text: "Word", translated_text: "Слово")
    original_review_date = card.review_date
    card.check_translation("Словечко")
    expect(card.review_date).to eql(original_review_date)
  end
end
