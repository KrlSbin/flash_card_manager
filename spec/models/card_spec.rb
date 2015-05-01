require "rails_helper"

describe Card do
  it "not save instance with identical original and translated text fields" do
    card = Card.new(original_text: "Word", translated_text: "Word", deck_id: 1)
    expect(card.valid?).to be false
  end

  it "save instance with different original and translated text fields" do
    card = Card.new(original_text: "Word",
                    translated_text: "Слово", deck_id: 1)
    expect(card.valid?).to be true
  end

  it "check positive translation" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово", deck_id: 1)
    expect(card.check_translation("Слово")[:success]).to be true
  end

  it "check negative translation" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово", deck_id: 1)
    expect(card.check_translation("Словечки")[:success]).to be false
  end

  it "update review date if translation is correct" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date.to_s).to eql (original_review_date + 12.hours).to_s
  end

  it "update review date if translation is correct for box 2" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 2)
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date.to_s).to eql (original_review_date + 3.days).to_s
  end

  it "update box number if translation is correct for box 2" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 2)
    original_box_number = card.box_number
    card.check_translation("Слово")
    expect(card.box_number).to eql(original_box_number + 1)
  end

  it "update review date if translation is correct for box 3" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 3)
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date.to_s).to eql (original_review_date + 7.days).to_s
  end

  it "update box number if translation is correct for box 3" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 3)
    original_box_number = card.box_number
    card.check_translation("Слово")
    expect(card.box_number).to eql(original_box_number + 1)
  end

  it "update review date if translation is correct for box 4" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 4)
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date.to_s).to eql (original_review_date + 14.days).to_s
  end

  it "update box number if translation is correct for box 4" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 4)
    original_box_number = card.box_number
    card.check_translation("Слово")
    expect(card.box_number).to eql(original_box_number + 1)
  end

  it "update review date if translation is correct for box 5" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 5)
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date.to_s).to eql (original_review_date + 1.month).to_s
  end

  it "update box number if translation is correct for box 5" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 5)
    original_box_number = card.box_number
    card.check_translation("Слово")
    expect(card.box_number).to eql(original_box_number + 1)
  end

  it "update review date if translation is correct for box 6" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    card.update_attributes(box_number: 6)
    original_review_date = card.review_date
    card.check_translation("Слово")
    expect(card.review_date.to_s).to eql (original_review_date + 1.month).to_s
  end

  it "reset review date after three fail translation attempts" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    original_review_date = card.review_date
    3.times { card.check_translation("Словоу") }
    expect(card.review_date.to_s).to eql (original_review_date + 12.hours).to_s
  end

  it "update box number if translation is correct" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    original_box_number = card.box_number
    card.check_translation("Слово")
    expect(card.box_number).to eql(original_box_number + 1)
  end

  it "update attempt if translation is not correct" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    original_attempt = card.attempt
    card.check_translation("Словоу")
    expect(card.attempt).to eql(original_attempt + 1)
  end

  it "reset attempt field to zero after three fail translation attempts" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    3.times { card.check_translation("Словоу") }
    expect(card.attempt).to eql(0)
  end

  it "not update review date if translation is not correct" do
    card = Card.create(original_text: "Word",
                       translated_text: "Слово",
                       deck_id: 1)
    original_review_date = card.review_date
    card.check_translation("Словечко")
    expect(card.review_date).to eql(original_review_date)
  end

  it "send notification about new card to review" do
    user = create(:user)
    user.cards.create(original_text: "Word",
                      translated_text: "Слово",
                      deck_id: 1)
    expect { Card.mail_cards_to_review }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
