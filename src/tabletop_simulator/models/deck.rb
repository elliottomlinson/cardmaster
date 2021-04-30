require "json"
require "json-schema"
require_relative "./card.rb"
require_relative "./object.rb"

module TabletopSimulator
  module Models
    class Deck
      extend Object

      SCHEMA = single_object_state({
        "type" => "object",
        "required" => ["CustomDeck", "ContainedObjects"],
        "properties" => {
          "CustomDeck" => {
            "type" => "object",
            "additionalProperties" => {
              "type" => "object",
              "required" => ["FaceURL", "BackURL"],
              "properties" => {
                "FaceURL" => {
                  "type" => "string",
                },
                "BackURL" => {
                  "type" => "string",
                }
              }
            }
          },
          "ContainedObjects" => {
            "type" => "array",
            "items" => Card::INNER_SCHEMA
          }
        }
      })

      def initialize(hash)
        @hash = hash

        validation_errors = JSON::Validator.fully_validate(SCHEMA, @hash)

        raise "Deck Validation Failed: #{validation_errors}" if validation_errors.length > 0
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
