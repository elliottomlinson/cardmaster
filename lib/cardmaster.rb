require 'cli/ui'
require 'cli/kit'
require_relative 'cardmaster/arguments'
require_relative "./card/catalogue_adapters.rb"
require_relative "./card/models.rb"

CLI::UI::StdoutRouter.enable

module Cardmaster
  extend CLI::Kit::Autocall

  TOOL_NAME = 'cardmaster'
  ROOT      = File.expand_path('../..', __FILE__)
  LOG_FILE  = '/tmp/cardmaster.log'

  autoload(:EntryPoint, 'cardmaster/entry_point')
  autoload(:Commands,   'cardmaster/commands')

  autocall(:Config)  { CLI::Kit::Config.new(tool_name: TOOL_NAME) }
  autocall(:Command) { CLI::Kit::BaseCommand }

  autocall(:Executor) { CLI::Kit::Executor.new(log_file: LOG_FILE) }
  autocall(:Resolver) do
    CLI::Kit::Resolver.new(
      tool_name: TOOL_NAME,
      command_registry: Cardmaster::Commands::Registry
    )
  end

  autocall(:ErrorHandler) do
    CLI::Kit::ErrorHandler.new(
      log_file: LOG_FILE,
      exception_reporter: nil
    )
  end
end
