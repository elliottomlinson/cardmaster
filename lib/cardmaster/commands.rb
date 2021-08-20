require 'cardmaster'

module Cardmaster
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(
      default: 'help',
      contextual_resolver: nil
    )

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Query, 'query', 'cardmaster/commands/query'
    register :Generate, 'generate', 'cardmaster/commands/generate'
    register :Help,    'help',    'cardmaster/commands/help'
  end
end
