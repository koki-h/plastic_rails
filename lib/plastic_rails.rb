require "thor"
require "plastic_rails/version"
require "plastic_rails/fileutils"
  THOR_SILENCE_DEPRECATION = true

module PlasticRails
  class Error < StandardError; end

  class PlaRails < Thor
    include Thor::Actions
    DEFAULT_TEMPLATE_DIR = File.join(File.dirname(__FILE__) , "tmpl")

    def self.exit_on_failure?
      # コマンドが失敗したときに終了ステータス１を返すようにする設定
      true
    end

    desc "new [APPNAME]", "Create a Rails application skelton with Docker container."
    option :db_path, :default => "./db/mysql/volumes"
    option :template, :default => DEFAULT_TEMPLATE_DIR
    def new(appname)
      run("cp -a #{options[:template]} #{appname}")
      Dir.chdir(appname)

      # DBのファイルパスを設定する
      FileUtils.sed("docker-compose.yml", /%DB_PATH%/, options[:db_path]) 

      # Dockerイメージビルド＆rails new (working_dirは `/apps`)
      run("./build.sh #{appname}")

      # working_dirをrailsアプリのディレクトリに変更する
      FileUtils.sed("docker-compose.yml", /(working_dir: \/apps\/)/, '\1' + appname) 

      # Railsアプリの設定（`bundle install`, `rails db:setup` など）
      run("./setup.sh")
    end

    desc "login", "Log in Rails container related to current directory."
    def login
      run("docker-compose exec web bash")
    end

    desc "up", "Start up Rails container related to current directory."
    def up
      run("docker-compose up -d")
    end

    desc "stop", "Stop Rails container related to current directory."
    def stop
      run("docker-compose stop")
    end

    desc "down", "Stop and remove Rails container related to current directory."
    def down
      run("docker-compose down")
    end

    desc "copy_template [DEST_DIR]", "Copy the default template to any dir. (To use in `new` command with `--template` option.)"
    def copy_template(dest_dir)
      run("cp -a #{DEFAULT_TEMPLATE_DIR} #{dest_dir}")
    end
  end
end
