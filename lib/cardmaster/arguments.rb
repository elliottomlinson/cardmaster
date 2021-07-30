module Arguments
	NAMED_ARGUMENT_REGEX = /--(.*)=(.*)/
	def named_arguments(args)
		args.each_with_object({}) do |arg, dict|
			match = NAMED_ARGUMENT_REGEX.match(arg)
			next if match.nil?

			dict[match[1]] = match[2]
		end
	end
end