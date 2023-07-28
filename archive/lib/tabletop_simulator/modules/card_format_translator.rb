require_relative "../models/object.rb"

module TabletopSimulator
  module CardFormatTranslator
    # I have no idea why Tabletop Simulator works this way.
    # It seems to need card IDs to be divisible by 100
    BASE_CARD_ID = 100
    CARD_ID_INCREMENT = 100

    def translate_card(stored_card, card_id=nil)
      TabletopSimulator::Models::ObjectState.card(
        nickname: stored_card.spec.title,
        front_url: stored_card.image_url,
        back_url: stored_card.back_url,
        card_id: card_id
      )
    end

    def translate_cards(stored_cards)
      card_id = BASE_CARD_ID

      stored_cards.map do |card|
        translated_card = translate_card(card, card_id)

        card_id += CARD_ID_INCREMENT

        translated_card
      end
    end
  end
end
