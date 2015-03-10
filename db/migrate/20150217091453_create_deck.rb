class CreateDeck < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name

      t.timestamps
    end

    add_reference :users, :current_deck
    add_reference :decks, :user, index: true
    add_reference :cards, :deck, index: true
  end
end
