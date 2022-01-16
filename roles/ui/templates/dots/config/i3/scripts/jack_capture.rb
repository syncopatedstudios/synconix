#!/usr/bin/env ruby

#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-command'

def cmd
  cmd = TTY::Command.new(printer: :pretty)
  return cmd
end

def forkoff(command)
  fork do
    exec("#{command}")
  end
end

def status(service)
  `pgrep -u #{ENV["USER"]} -a -l #{service}`.chomp
end

host = ARGV[0]

# seeedbot = {
#   pimic: [ "system:capture_1", "system:capture_2", "system:capture_3", "system:capture_4" ],
#
#   powermic: ['powermic:capture_1'],
#
#   jacktrip01: [ "#{host}:send_1", "#{host}:send_2", "#{host}:send_3", "#{host}:send_4" ],
#
#   jacktrip02: [ "#{host}:send_5"]
#
# }
#
# pimic_to_jacktrip = Hash[seeedbot[:pimic].zip seeedbot[:jacktrip01]]
# powermic_to_jacktrip = Hash[seeedbot[:powermic].zip seeedbot[:jacktrip02]]

Dir.chdir("/tmp")

forkoff("jacktrip -s -n 5 -D --udprt")

forkoff("uxterm -T 'seeedbot' -e ssh -v seeedbot 'ruby soundbot01.rb calculon'")

forkoff("uxterm -T 'jack_capture' -e jack_capture -f wav -mb -tm -tmpb 10 --channels 6 --port 'JackTrip:receive*' --port 'PowerMicII-NS:capture_MONO' --osc 9999")
