require "thor"
require "plastic_rails/version"
require "plastic_rails/fileutils"

module PlasticRails
  class Error < StandardError; end

  class PlaRails < Thor
    TMPL_DIR=File.dirname(__FILE__)
    p TMPL_DIR
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

    desc "login", "log in Rails container related to current directory."
    def login
      execute("docker-compose exec web bash")
    end

    private

    def execute(cmd)
      puts cmd
      system(cmd)
    end
  end
end
