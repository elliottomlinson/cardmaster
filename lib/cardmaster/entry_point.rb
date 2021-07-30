require 'cardmaster'

module Cardmaster
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Cardmaster::Resolver.call(args)
      Cardmaster::Executor.call(cmd, command_name, args)
    end
  end
end
