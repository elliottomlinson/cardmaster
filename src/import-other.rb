require_relative "./templates.rb"
require_relative "./config.rb"
require 'fileutils'

FileUtils.copy_entry MISC_GIT_DIR, MISC_SAVED_DIR
