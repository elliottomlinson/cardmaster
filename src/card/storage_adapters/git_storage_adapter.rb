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

      def save(cards)
        cards.each do |card|
          FileUtils.cp(
            card.image_path,
            card_file_name(card)
          )
        end

        update_manifest(cards)
      end

      def printed_cards
        raise "Git Print Manifest unavailable, try regenerating assets" unless File.exists?(PRINT_MANIFEST_PATH)

        Marshal.load(File.read(PRINT_MANIFEST_PATH)).each do |printed_card|
          printed_card.image_url = github_repo_url(printed_card)
        end
      end

      private

      def update_manifest(cards)
        File.write(PRINT_MANIFEST_PATH, Marshal.dump(cards))
      end

      def card_file_name(card)
        File.join(ASSET_PATH, "#{card.spec.title}.png")
      end

      def github_repo_url(card)
        "#{GH_URL}/master/#{card_file_name(card)}"
      end
    end
  end
end
