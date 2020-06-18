# Plastic Rails
docker上にRuby on Railsの環境を一発で作るスクリプト

プラレールのように自分用のレールを引こう

## Requirements
- Docker
- Docker Compose
- ruby

## install 

```
gem install plastic_rails
```

## 環境の作成
以下の手順を実行すると http://localhost:3000 でrailsのテストページが表示できるようになる。

- rails new済のDockerコンテナを作成する
  - `plastic_rails new <APP_NAME>`
- コンテナのシェルにログインする
  -  `cd <APP_NAME>; docker-compose exec web bash; `
- コンテナ上でRails serverを起動する
  - `rails s -b 0.0.0.0`

## 環境の操作
環境を作成した後は以下のコマンドで環境を操作する。

- コンテナ停止（<APP＿NAME>ディレクトリで）
  -  `docker-compose stop`
- コンテナ削除（<APP＿NAME>ディレクトリで）
  -  `docker-compose down`
- 削除したコンテナを再セットアップ
  -  `./setup.sh`

## Plastic Rails自体の開発・デバッグ
### デバッグ環境（Vagrant）作成
- あらかじめ、VirtualboxとVagrantをインストールしておく。
- Vagrantfileをダウンロード
```
curl https://gist.githubusercontent.com/koki-h/8a2990ac49f37124dc90523ef1e635ed/raw/c9cd49f79d1b27c12441a344dbd980ac71e9aacc/Vagrantfile > Vagrantfile
```
- Virtualbox起動。最初からrequirementsが入ったVirtualboxができる
```
$ vagrant up 
```
- `vagrant ssh` で virtualboxにログインし、適当なディレクトリで `git clone https://github.com/koki-h/plastic_rails.git` する。
- セットアップ実行
```
$ cd plastic_rails
$ ./bin/setup
```


### Vagrant環境での実行方法
```
$ plastic_rails new <APP_NAME> --db_path=<DB_PATH>
```
Plastic RailsをVirtualboxの共有ディレクトリにインストールした場合は --db-path オプションでDBファイルのパスを共有ディレクトリ以外に指定する。（そうしないとパーミッションの関係でMySqlサーバが起動しない）

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/koki-h/plastic_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlasticRails project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koki-h/plastic_rails/blob/master/CODE_OF_CONDUCT.md).
