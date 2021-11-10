#!/usr/bin/env ruby

require "taglib"
include TagLib

file_name = ARGV[0]
puts "Metadata for #{file_name}:"

begin

  TagLib::RIFF::AIFF::File.open(file_name) do |file|
    id3v2_tag = file.tag
    cover = id3v2_tag.frame_list('APIC').first
  end
rescue StandardError => e
  puts "#{e.message}"
end
