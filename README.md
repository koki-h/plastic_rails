# Plastic Rails
docker上にRuby on Railsの環境を一発で作るスクリプト

プラレールのように自分用のレールを引こう

## Requirements
- Docker
- Docker Compose
- ruby
  - Thor (rubygems)
    - `gem install thor` するなどして環境にインストールしておく。
- `plarails.rb` にPATHが通った状態にしておく。

## 環境の作成
以下の手順を実行すると http://localhost:3000 でrailsのテストページが表示できるようになる。

- rails new済のDockerコンテナを作成する
  - `plarails.rb new <APP_NAME>`
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
$ wget https://gist.github.com/koki-h/8a2990ac49f37124dc90523ef1e635ed 
```
- Virtualbox起動。最初からrequirementsが入ったVirtualboxができる
```
$ vagrant up 
```
- `vagrant ssh` で virtualboxにログインし、適当なディレクトリで `git clone https://github.com/koki-h/plastic_rails.git` する。

### Vagrant環境での実行方法
```
$ plarails.rb new <APP_NAME> --db_path=<DB_PATH>
```
Plastic RailsをVirtualboxの共有ディレクトリにインストールした場合は --db-path オプションでDBファイルのパスを共有ディレクトリ以外に指定する。（そうしないとパーミッションの関係でMySqlサーバが起動しない）
