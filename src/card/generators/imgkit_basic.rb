require 'bundler/setup'
require "imgkit"
require "mustache"

module Card
  module Generators
    class IMGKitBasic
      def initialize(html_template_path, stylesheets)
        template = File.read(html_template_path)

        html = template

        @kit = IMGKit.new(html)
        @kit.stylesheets = stylesheets
      end

      def generate(card, output_path)
        file = @kit.to_file(output_path)
      end

      private

      class MustacheCard < Mustache
        attr_accessor :title, :rules, :upgrade, :flavour, :art_path

        def initialize(card_specification)
          @title = card_specification.title
          @rules = card_specification.rules
          @upgrade = card_specification.upgrade
          @flavour = card_specification.flavour
          @art_path = card_specification.art_path
        end
      end
    end
  end
end
