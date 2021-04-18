require "json"
require "json-schema"

CARD_SCHEMA = {
  "type" => "object",
  "required" => ["ObjectStates"],
  "properties" => {
    "ObjectStates" => {
      "type" => "array",
      "items" => {
        "type" => "number"
      },
      "format" => "single-object-state"
    }
  }
}

JSON::Validator.register_format_validator(
  "single-object-state",
  ->(value) {
    raise JSON::Schema::CustomFormatError.new("Multistate Cards not supported") unless value.length == 0
  }
)

module TabletopSimulator
  module Models
    class Card
      TEMPLATE = "data/testcard.json"

      def initialize(hash)
        @hash = hash

        JSON::Validator.fully_validate(CARD_SCHEMA, @hash)
      end

      def self.from_template()
        raise "Template at #{TEMPLATE} is missing" unless File.exists?(TEMPLATE)

        self.new(JSON.load(File.read(TEMPLATE)))
      rescue JSON::ParserError => e
        raise "Template at #{TEMPLATE} failed parsing: #{e.inspect}"
      end

      def name
        object_state["Nickname"].empty? ? object_state["Name"] : object_state["Nickname"]
      end

      def name=(val)
        object_state["Nickname"] = val
      end

      def to_json
        @hash.to_json
      end

      private

      def object_state
        @hash["ObjectStates"][0]
      end
    end
  end
end
