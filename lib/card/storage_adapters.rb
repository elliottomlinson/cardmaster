module Card
  module StorageAdapters
    class Abstract
      # Takes a list of Card::Models::PrintedCards
      # stores the images in a location which can be
      # retrieved via the stored_cards method
      def save(cards)
        raise UnimplementedError
      end

      # Retrieve a list of Card::Models::StoredCards,
      # one for each card stored by this adapter
      def stored_cards(cards)
        raise UnimplementedError
      end

      # Request that a card with the given title be deleted.
      # It will not be returned by stored_cards afterwards.
      def delete(title)
        raise UnimplementedError
      end
    end
  end
end

require_relative "./storage_adapters/git_storage_adapter.rb"
