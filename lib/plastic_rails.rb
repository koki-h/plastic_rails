require "thor"
require "plastic_rails/version"
require "plastic_rails/fileutils"

module PlasticRails
  class Error < StandardError; end

  class PlaRails < Thor
    DEFAULT_TEMPLATE_DIR = File.join(File.dirname(__FILE__) , "tmpl")
    desc "new APPNAME", "Create a Rails application skelton with Docker container."
    option :db_path, :default => "./db/mysql/volumes"
    option :template, :default => DEFAULT_TEMPLATE_DIR
    def new(appname)
      execute("cp -a #{options[:template]} #{appname}")
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

    desc "login", "Log in Rails container related to current directory."
    def login
      execute("docker-compose exec web bash")
    end


    desc "copy_template", "Copy the default template to any dir. (To use in `new` command with `--template` option.)"
    def copy_template(dest_dir)
      execute("cp -a #{DEFAULT_TEMPLATE_DIR} #{dest_dir}")
    end

    private

    def execute(cmd)
      puts cmd
      system(cmd)
    end
  end
end
