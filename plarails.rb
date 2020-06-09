#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require "thor"
require "lib/fileutils.rb"

class PlaRails < Thor
  TMPL_DIR=File.dirname(__FILE__)
  desc "new APPNAME", "create a Rails application skelton with Docker container."
  option :db_path, :default => "./db/mysql/volumes"
  def new(appname)
    execute("cp -a #{TMPL_DIR}/tmpl #{appname}")
    Dir.chdir(appname)

    # DBのファイルパスを設定する
    FileUtils.sed("docker-compose.yml",/%DB_PATH%/,options[:db_path]) 

    # Dockerイメージビルド＆rails new (working_dirは `/apps`)
    execute("./build.sh #{appname}")

    # working_dirをrailsアプリのディレクトリに変更する
    FileUtils.sed("docker-compose.yml",/(working_dir: \/apps\/)/,'\1' + appname) 
  
    # Railsアプリの設定（`bundle install`, `rails db:setup` など）
    system("./setup.sh")
  end

  private

  def execute(cmd)
    puts cmd
    system(cmd)
  end
end

PlaRails.start(ARGV)
