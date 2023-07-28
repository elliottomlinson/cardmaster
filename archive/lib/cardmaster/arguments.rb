module Arguments
	NAMED_ARGUMENT_REGEX = /--(.*)=(.*)/
  FLAG_REGEX = /--([^=]*)/

	def named_arguments(args)
		args.each_with_object({}) do |arg, dict|
			match = NAMED_ARGUMENT_REGEX.match(arg)
			next if match.nil?

			dict[match[1]] = match[2]
		end
	end

	def flag_arguments(args)
    args.map do |arg|
      next unless NAMED_ARGUMENT_REGEX.match(arg).nil?
      next if (match = FLAG_REGEX.match(arg)).nil?

      match[1]
    end.compact
	end

  def positional_arguments(args)
    args.select do |arg|
      NAMED_ARGUMENT_REGEX.match(arg).nil? && FLAG_REGEX.match(arg).nil?
    end
  end
end