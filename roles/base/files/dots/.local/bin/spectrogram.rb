#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'tty-command'

def cmd
  cmd = TTY::Command.new(uuid: false)
  return cmd
end

files = ARGV

files = files.map { |file| file.shellescape }

files.each do |source|

  sourcefile = Pathname.new(source).realdirpath
  puts "#{sourcefile}"

  next if sourcefile.directory?

  #TODO: get duration./ find the highest frequency that registers over -70dBFS
  # if freq = 1000 and dBFS > -70
  #   then sample_rate = 2K
  # if freq = 2000 and dBFS > -70
  #   then sample_rate = 4k
  # if freq = 5000 and dBFS > -70
  #   then sample_rate = 10k
  #
  #
  # silvetnotes yields:
  # => [{"filename"=>
  #    "/home/b08x/Library/Sounds/collections/Another_thing/A#1_ff_looped.flac",
  #   "start"=>"0.040000000",
  #   "finish"=>"0.120000000",
  #   "frequency"=>"783.991",
  #   "velocity"=>"20"},
  #  {"filename"=>"",
  #   "start"=>"0.040000000",
  #   "finish"=>"0.200000000",
  #   "frequency"=>"415.305",
  #   "velocity"=>"27"},
  #  {"filename"=>"",
  #   "start"=>"0.020000000",
  #   "finish"=>"0.540000000",
  #   "frequency"=>"174.614",
  #   "velocity"=>"70"},
  #  {"filename"=>"",
  #   "start"=>"0.260000000",
  #   "finish"=>"0.300000000",
  #   "frequency"=>"1396.91",
  #   "velocity"=>"43"},
  #  {"filename"=>"",
  #   "start"=>"0.020000000",
  #   "finish"=>"8.800000000",
  #   "frequency"=>"116.541",
  #   "velocity"=>"127"}]
  #
  #   aubiopitch yields: 0.000000000,8.672000000,max,902.23,"(maximum value)"
  #
  #

  spectrogram01 = File.join(sourcefile.dirname, sourcefile.basename.sub(sourcefile.extname, "_hamming.png"))

  spectrogram02 = File.join(sourcefile.dirname, sourcefile.basename.sub(sourcefile.extname, "_kaiser.png"))

  # -Y :
  # 2K = 550
  # 4K = 1100
  # 2000 is max

  # cmd.run("sox -V2 #{sourcefile.to_s.shellescape} -n rate 2k spectrogram -X 100 -d #{duration} -Y 550 -Z -10 -h -w Hann -o #{spectrogram01.shellescape}")

  cmd.run("sox -V2 #{sourcefile.to_s.shellescape} -n rate 24k spectrogram -X 100 -Y 550 -Z -10 -h -w hamming -o #{spectrogram01.shellescape}")

  cmd.run("sox -V2 #{sourcefile.to_s.shellescape} -n remix 1 spectrogram -x 3000 -y 513 -z 120 -w Kaiser -o #{spectrogram02.shellescape}")

  if sourcefile.extname == ".flac"

    `metaflac --remove --block-type=PICTURE,PADDING --dont-use-padding #{sourcefile}`

    `metaflac --import-picture-from="3||||#{spectrogram01}" --import-picture-from="4||||#{spectrogram02}" #{sourcefile}`

  elsif sourcefile.extname == ".mp3"
    #cmd.run("lame --ti #{spectrogram01} #{sourcefile.basename}")
    cmd.run("eyeD3 --add-image='#{spectrogram01}':FRONT_COVER #{sourcefile.basename}")
  end


  FileUtils.rm_f(spectrogram01)
  FileUtils.rm_f(spectrogram02)

end

10.times do
  puts "\n"
end

puts "--------------------"
puts "conversion complete!\n"
puts "--------------------"

sleep 1
exit
