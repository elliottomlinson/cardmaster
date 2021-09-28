require 'bundler/setup'
require "imgkit"
require "mustache"

module Card
  module Generators
    class IMGKitBasic
      def initialize(template_function, stylesheet, scripts, resource_path)
        @template_function = template_function
        @stylesheet = stylesheet
        @resource_path = resource_path
        @scripts = scripts
        IMGKit.configure do |config|
          config.default_options = { encoding: "UTF-8" }
        end
      end

      def generate(card_specification, output_path)
        CardTemplate.template_file = @template_function.call(card_specification) 
        CardStyleTemplate.template_file = @stylesheet

        html = render_html_mustache(card_specification)
        css = render_css_mustache(card_specification)

        File.write("generated_stylesheet.css", css)

        kit = IMGKit.new(html, "crop-w" => 816, "crop-h" => 1154, transparent: true)
        kit.stylesheets = ["./generated_stylesheet.css"]
        kit.javascripts = @scripts 

        kit.to_file(output_path)
      end

      private

      def render_css_mustache(card_specification)
        CardStyleTemplate.render(
          tier_image_path: File.join(@resource_path, "/art/tier/#{card_specification.tier.to_s}.png"), 
          border_image_path: File.join(@resource_path, "/art/border/border.png"),
          frame_image_path: File.join(@resource_path, "/art/frame/#{card_specification.tier.to_s}.png"),
          title_image_path: File.join(@resource_path, "/art/title/#{card_specification.tier.to_s}.png"),
          illustration_image_path: File.join(@resource_path, "..", card_specification.art_path),
          type_image_path: File.join(@resource_path, "/art/type/#{card_specification.tier.to_s}.png"),
          rules_image_path: File.join(@resource_path, "/art/rules/#{card_specification.tier.to_s}.png"),
          hand_glyph_image_path: File.join(@resource_path, "/art/glyph/hand.png"),
          cast_glyph_image_path: File.join(@resource_path, "/art/glyph/cast.png")
        )
      end

      def render_html_mustache(card_specification)
        active, passive = generate_rules_content(card_specification.rules)

        CardTemplate.render(
          title: card_specification.title,
          active_rules: active,
          passive_rules: passive,
          upgrade: generate_upgrade_content(card_specification),
          flavour: card_specification.flavour,
          art_path: card_specification.art_path
        )
      end

      def generate_upgrade_content(card_specification)
        return '' if card_specification.tier == :gold
        card_specification.upgrade || "Random #{card_specification.next_tier} Card"
      end

      def generate_rules_content(rules)
        case rules
        when Card::Models::SimpleRules
          [rules.text, nil]
        when Card::Models::PassiveActiveRules
          [rules.active, rules.passive]
        else
          raise "Unsupported rule type #{rules.class}"
        end
      end

      class CardTemplate < Mustache
        attr_accessor :title, :rules, :upgrade, :flavour, :art_path
      end

      class CardStyleTemplate < Mustache
        attr_accessor :tier_image_path, :border_image_path, :frame_image_path, :title_image_path, :illustration_image_path, :type_image_path, :rules_image_path, :hand_glyph_image_path, :cast_glyph_image_path
      end
    end
  end
end
