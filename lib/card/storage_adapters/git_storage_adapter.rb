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
      GH_URL = "https://raw.githubusercontent.com/elliottomlinson/rpcg"
      HELP_SUGGESTION = "try printing again or reverting changes to #{@print_manifest_path}"

      def initialize(print_manifest_path)
        @print_manifest_path = print_manifest_path
        @stored_cards = {}

        manifest = load_manifest

        parse_manifest(manifest)
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

      def load_manifest
        if File.exists?(@print_manifest_path)
          raw_manifest = File.read(@print_manifest_path)
          JSON.parse(raw_manifest)
        else
          puts "Warning: No Print Manifest found at #{@print_manifest_path}"
          {}
        end
      end

      def parse_manifest(manifest)
        manifest.each do |title, hash|
          @stored_cards[title] = Card::Models::StoredCard.from_h(hash)
        end
      end

      def update_manifest
        File.write(@print_manifest_path, JSON.pretty_generate(@stored_cards.transform_values(&:to_h)))
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
