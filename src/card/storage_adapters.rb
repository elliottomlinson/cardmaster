module Card
  module StorageAdapters
    class Abstract
      # Takes a list of Card::Models::PrintedCards
      # stores the images in a location which can be
      # loaded via the load method
      def save(cards)
        raise UnimplementedError
      end

      # Takes a list of Card::Models::CardSpecification
      # Returns a list of tuples matching CardSpecifications
      # with resource URLs
      def load(cards)
        raise UnimplementedError
      end
    end
  end
end

require_relative "./storage_adapters/git_storage_adapter.rb"
