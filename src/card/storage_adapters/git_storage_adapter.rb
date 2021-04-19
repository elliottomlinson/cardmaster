require_relative "../models.rb"
require "open-uri"

module Card
  module StorageAdapters
    # Saves the images in the local git repository
    class GitStorageAdapter < Abstract
      # todo move to config
      ASSET_PATH = "assets/core/card/printed"
      PRINT_MANIFEST_PATH = "assets/core/card/printed/print_manifest.json"
      GH_URL = "https://raw.githubusercontent.com/elliottomlinson/rpcg"

      def save(printed_cards)
        printed_cards.each do |printed_card|
          FileUtils.cp(
            printed_card.image_path,
            card_file_name(printed_card)
          )
        end

        update_manifest(printed_cards)
      end

      def printed_cards
        raise "Git Print Manifest unavailable, try printing again" unless File.exists?(PRINT_MANIFEST_PATH)

        stored_cards = Marshal.load(File.read(PRINT_MANIFEST_PATH))

        raise "Print Manifest Invalid, try printing again" unless stored_cards[0].is_a?(Card::Models::StoredCard)

        stored_cards
      end

      private

      def update_manifest(printed_cards)
        stored_cards = printed_cards.map do |printed_card|
          Card::Models::StoredCard.new(printed_card.spec, github_repo_url(printed_card))
        end

        File.write(PRINT_MANIFEST_PATH, Marshal.dump(stored_cards))
      end

      def card_file_name(printed_card)
        File.join(ASSET_PATH, "#{printed_card.spec.title}.png")
      end

      def github_repo_url(printed_card)
        "#{GH_URL}/master/#{card_file_name(printed_card)}"
      end
    end
  end
end
