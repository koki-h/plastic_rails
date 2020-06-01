#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require "thor"
require "lib/fileutils.rb"

class PlaRails < Thor
  desc "new APPNAME", "create a Rails application skelton with Docker container."
  def new(appname)
    execute("cp -a tmpl #{appname}")
    Dir.chdir(appname)
    execute("./build.sh #{appname}")
    FileUtils.sed("docker-compose.yml",/(working_dir: \/apps\/)/,'\1' + appname) # working_dirをrailsアプリのディレクトリに変更する
    system("./setup.sh")
  end

  private

  def execute(cmd)
    puts cmd
    system(cmd)
  end
end

PlaRails.start(ARGV)
