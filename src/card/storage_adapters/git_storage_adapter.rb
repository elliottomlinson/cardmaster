require_relative "../models.rb"
require "open-uri"

module Card
  module StorageAdapters
    # Saves the images in the local git repository
    class GitStorageAdapter < Abstract
      # todo move to config
      ASSET_BASE = "res/card"
      FRONT_PATH = File.join(ASSET_BASE, "printed")
      BACK_PATH = File.join(ASSET_BASE, "back")
      PRINT_MANIFEST_PATH = "res/card/printed/print_manifest.json"
      GH_URL = "https://raw.githubusercontent.com/elliottomlinson/cardmaster"
      HELP_SUGGESTION = "try printing again or reverting changes to #{PRINT_MANIFEST_PATH}"

      def initialize
        if File.exists?(PRINT_MANIFEST_PATH)
          @stored_cards = Marshal.load(File.read(PRINT_MANIFEST_PATH))
          raise "Print Manifest Invalid, #{HELP_SUGGESTION}" unless @stored_cards.is_a?(Hash) && @stored_cards.all? do |title, stored_card|
            stored_card.is_a?(Card::Models::StoredCard)
            title.is_a?(String)
          end
        else
          puts "Warning: No Print Manifest found at #{PRINT_MANIFEST_PATH}"
          @stored_cards = {}
        end
      end

      def save(printed_cards)
        save_images(printed_cards)

        printed_cards.each do |printed_card|
          @stored_cards[printed_card.spec.title] = Card::Models::StoredCard.new(
            printed_card.spec,
            github_repo_url(front_path(printed_card.spec)),
            github_repo_url(printed_card.back_path)
          )
        end

        update_manifest
      end

      def delete(title)
        deleted_card = @stored_cards.delete(title)

        delete_image(deleted_card)

        update_manifest
      end

      def stored_cards
        @stored_cards.values
      end

      private

      def delete_image(stored_card)
        FileUtils.rm(
          front_path(stored_card.spec)
        )
      end

      def save_images(printed_cards)
        printed_cards.each do |printed_card|
          FileUtils.cp(
            printed_card.image_path,
            front_path(printed_card.spec)
          )
        end
      end

      def update_manifest
        File.write(PRINT_MANIFEST_PATH, Marshal.dump(@stored_cards))
      end

      def front_path(card_spec)
        File.join(FRONT_PATH, "#{card_spec.title}.png")
      end

      def github_repo_url(path)
        "#{GH_URL}/master/#{path}"
      end
    end
  end
end
