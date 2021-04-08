module Card
  module StorageAdapters
    # Saves the images in the local git repository
    class GitStorageAdapter < Abstract
      # todo move to config
      ASSET_PATH = "assets/core/card/printed"
      def save(cards)
        cards.each do |card|
          FileUtils.cp(
            card.image_path,
            card_file_name(card.spec)
          )
        end
      end

      private

      def card_file_name(card_spec)
        File.join(ASSET_PATH, "#{card_spec.title}.png")
      end
    end
  end
end
