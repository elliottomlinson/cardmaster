require_relative "../models.rb"

module Card
  module StorageAdapters
    # Saves the images in the local git repository
    class GitStorageAdapter < Abstract
      # todo move to config
      ASSET_PATH = "assets/core/card/printed"
      PRINT_MANIFEST_PATH = "assets/core/card/printed/print_manifest.json"

      def save(cards)
        cards.each do |card|
          FileUtils.cp(
            card.image_path,
            card_file_name(card.spec)
          )
        end

        update_manifest(cards)
      end

      def printed_cards
        raise "Git Print Manifest unavailable, try regenerating assets" unless File.exists?(PRINT_MANIFEST_PATH)

        Marshal.load(File.read(PRINT_MANIFEST_PATH))
      end

      private

      def update_manifest(cards)
        File.write(PRINT_MANIFEST_PATH, Marshal.dump(cards))
      end

      def card_file_name(card_spec)
        File.join(ASSET_PATH, "#{card_spec.title}.png")
      end
    end
  end
end
