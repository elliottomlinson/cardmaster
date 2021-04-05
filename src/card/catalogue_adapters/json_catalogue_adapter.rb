require "json"

module Card
  module CatalogueAdapters
    class JsonCatalogueAdapter
      class InvalidJsonCatalogue < RuntimeError; end

      def initialize(catalogue_path)
        @catalogue_path = catalogue_path
      end

      def printable_cards
        raise "Could not find catalogue at #{@catalogue_path}" unless File.exists?(@catalogue_path)

        raw_catalogue = File.read(@catalogue_path)

        parsed_catalogue = parse_catalogue!(raw_catalogue)

        build_cards(parsed_catalogue)
      end

      private

      def parse_catalogue!(raw)
        JSON.parse(raw)
      rescue JSON::ParserError => e
        raise "Failed to parse catalogue file at #{@catalogue_path}, received: #{e.inspect}"
      end

      def build_cards(catalogue)
        folders = catalogue["folders"] || raise_format_error!("Missing 'folders' key at top level")

        folders.reduce([]) do |card_list, folder|
          card_list + build_cards_recursively(folder, [])
        end.compact
      end

      def build_cards_recursively(node, parent_names)
        if node["title"].nil? && node["folder"].nil?
          raise_format_error!("Node #{node} under #{parent_names} has neither the 'folder' key nor the 'title' key, unable to ascertain if its a card or a folder")
        elsif node["folder"]
          build_folder_recursively(node, parent_names)
        else
          [build_card(node, parent_names)]
        end
      end

      def build_folder_recursively(folder, parent_names)
        name_hierarchy = parent_names + [folder["folder"]]
        folder_content = validate_field!(folder, "content", name_hierarchy, "Folder")
        raise_format_error!("Folder under #{name_hierarchy} must have an array under the 'content' key") unless folder_content.is_a?(Array)

        folder_content.reduce([]) do |card_list, node|
          card_list + build_cards_recursively(node, name_hierarchy)
        end
      end

      def build_card(card, parent_names)
        return if card["draft"]

        name_hierarchy = parent_names + [card["title"]]

        title = validate_field!(card, "title", name_hierarchy, "Card")
        details = validate_field!(card, "details", name_hierarchy, "Card")
        rules = validate_field!(details, "rules", name_hierarchy, "Card")
        flavour = validate_field!(details, "flavour", name_hierarchy, "Card")
        image_path = validate_field!(details, "image", name_hierarchy, "Card")

        tier = validate_tier!(card, name_hierarchy)

        upgrade = card["upgrade"]

        Card::Models::CardSpecification.new(title, rules, upgrade, tier, flavour, image_path, parent_names)
      end

      def validate_tier!(card, name_hierarchy)
        tier = validate_field!(card, "tier", name_hierarchy, "Card")

        allowable_tiers = Card::Models::CardSpecification::VALID_TIERS.map(&:to_s)
        unless allowable_tiers.include?(tier)
          raise_format_error!("Card at #{name_hierarchy} must have one of the following under the 'tier' key: #{allowable_tiers}. Received '#{tier}'")
        end

        tier.to_sym
      end

      def validate_field!(node, field_name, hierarchy, node_type_name)
        node[field_name] || raise_format_error!("#{node_type_name} #{hierarchy} is missing '#{field_name}' key")
      end

      def raise_format_error!(message)
        raise InvalidJsonCatalogue, "Invalid catalogue file at location '#{@catalogue_path}': #{message}"
      end
    end
  end
end
