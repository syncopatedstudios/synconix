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
  spectrogram01 = File.join(sourcefile.dirname, sourcefile.basename.sub(sourcefile.extname, "_hamming.png"))

  spectrogram02 = File.join(sourcefile.dirname, sourcefile.basename.sub(sourcefile.extname, "_kaiser.png"))


  cmd.run("sox -V2 #{sourcefile.to_s.shellescape} -n rate 24k spectrogram -x 1000 -z 90 -h -w hamming -o #{spectrogram01.shellescape}")

  cmd.run("sox -V2 #{sourcefile.to_s.shellescape} -n remix 1 spectrogram -x 3000 -y 513 -z 120 -w Kaiser -o #{spectrogram02.shellescape}")

  if sourcefile.extname == ".flac"
    `metaflac --remove --block-type=PICTURE,PADDING --dont-use-padding #{sourcefile}`
    
    `metaflac --import-picture-from="3||||#{spectrogram01}" --import-picture-from="4||||#{spectrogram02}" #{sourcefile}`
    # cmd.run("metaflac --import-picture-from='3||||#{spectrogram01}' --import-picture-from='4||||#{spectrogram02}' #{sourcefile}")
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
