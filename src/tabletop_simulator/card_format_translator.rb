require_relative "models/object.rb"

module TabletopSimulator
  module CardFormatTranslator
    # I have no idea why Tabletop Simulator works this way.
    # It seems to need card IDs to be divisible by 100
    BASE_CARD_ID = 100
    CARD_ID_INCREMENT = 100

    def translate_card(printed_card, card_id=nil)
      TabletopSimulator::Models::ObjectState.card(
        nickname: printed_card.spec.title,
        front_url: printed_card.image_url,
        back_url: "http://cloud-3.steamusercontent.com/ugc/1770453729835188440/BA89FF48561CCA952BFB77A6C9891E0C38DB3559/",
        card_id: card_id
      )
    end

    def translate_cards(printed_cards)
      card_id = BASE_CARD_ID

      printed_cards.map do |card|
        translated_card = translate_card(card, card_id)

        card_id += CARD_ID_INCREMENT

        translated_card
      end
    end
  end
end
