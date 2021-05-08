require_relative "./config.rb"
require 'bundler/setup'

SESSIONS_GIT_DIR = GIT_DIR+"/assets/campaign"

$session = ''

sessions = Dir.children(SESSIONS_GIT_DIR)
puts "found "+sessions.length.to_s+" sessions"

sessions.each do |eachsession|
  $session = eachsession

  puts "processing session "+eachsession
  load "./dirs.rb"
  Dir.mkdir(SESSION_SAVED_DIR) unless File.exists?(SESSION_SAVED_DIR)

  load "./templates.rb"
  load "./import-map.rb"
  load "./import-char.rb"
  load "./import-bg.rb"
  load "./import-item.rb"
  load "./import-stated.rb"
  puts "done session"

end
  load "./import-tts-objs.rb"
puts "all done"
#  require_relative "./import-bg.rb"
#  require_relative "./import-char.rb"
#  require_relative "./import-item.rb"
#  require_relative "./import-map.rb"
#  require_relative "./import-stated.rb"
#  require_relative "./import-tts-objs.rb"
