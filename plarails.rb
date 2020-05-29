#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require "lib/fileutils.rb"

def execute(cmd)
  puts cmd
  system(cmd)
end

APPNAME=ARGV[0]
execute("cp -a tmpl #{APPNAME}")
Dir.chdir(APPNAME)
execute("./build.sh #{APPNAME}")
FileUtils.sed("docker-compose.yml",/(working_dir: \/apps\/)/,'\1' + APPNAME) # working_dirをrailsアプリのディレクトリに変更する
system("./setup.sh")
