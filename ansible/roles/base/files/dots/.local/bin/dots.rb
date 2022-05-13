#!/usr/bin/env ruby
# frozen_string_literal: True

require 'logger'
require 'fileutils'
require 'pathname'
require 'tty-command'

$logger = Logger.new(STDOUT)

$dots = File.join(ENV['HOME'], ".dots")

$backup = File.join(ENV['HOME'], ".dotsbackup")

$gitrepo = "git@github.com:b08x/dots.git"

$git = "/usr/bin/git --git-dir='#{$dots}' --work-tree='#{ENV['HOME']}'"

$modified_or_new = "egrep '.modified|.new' | awk -F ':' {'print $2'} | xargs -0"
$from_remote = "egrep '\t+\.' | awk {'print $1'}"

def cmd
  TTY::Command.new(output: $logger, 2 => 1)
end

def git(command,filter=nil)
  if filter.nil?
    cmd.run("#{$git} #{command}", chdir: "#{ENV["HOME"]}")
  else
    cmd.run("#{$git} #{command} 2>&1 | #{filter}", chdir: "#{ENV["HOME"]}")
  end
end

def status
  git("status", $modified_or_new).out.split("\n").map! { |file| file.strip  }
end

def backup(results)
  FileUtils.mkpath($backup) unless Dir.exist?($backup)
  begin
    files = results.split("\n")
  rescue NoMethodError
    files = results
  end

  files.each do |file|
    destination_folder = File.join($backup,Pathname.new(file).dirname.to_s)

    FileUtils.mkpath(destination_folder) unless Dir.exist?(destination_folder)

    file = File.join(ENV["HOME"], file)
    FileUtils.mv(file, destination_folder) if File.file?(file)
  end
end

if ARGV[0] == "init"
  unless Dir.exist?($dots)
   git("clone --bare #{$gitrepo} #{$dots}")
  end

  begin
   results = git("checkout", $from_remote)
  rescue StandardError => e
   puts "#{e.message}"
  end

  unless results.out.empty?
   backup(results.out)
   git("checkout")
  end
end

if ARGV[0] == "update"
  begin
    git("fetch")
    results = git("pull")
  rescue TTY::Command::ExitError => e
    results = e.message
  end

  begin
    results.split(':').each do |x|
      @files = x if x.match('\n\t')
    end
  rescue NoMethodError => e
    puts "#{e.message}\n#{results.out}exiting"
    exit
  end

  files = @files.gsub(/\n\t/,' ')
  files.gsub!(/Please\smove\sor\sremove\sthem\sbefore\syou\smerge.|Aborting/,'')
  files.strip!
  files.gsub!(' ','\n')
  files = files.split('\n')


  unless files.empty?
    backup(files)
    git("pull")
  end
end
