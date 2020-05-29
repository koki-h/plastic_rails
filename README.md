# Plastic Rails
docker上にRuby on Railsの環境を一発で作るスクリプト

プラレールのように自分用のレールを引こう

## Requirements
- Docker
- Docker Compose
- ruby

## 環境の作成
以下の手順を実行すると http://localhost:3000 でrailsのテストページが表示できるようになる。

- rails new済のDockerコンテナを作成する
  - `./plarails.sh <APP_NAME>`
  - うまく動かない(`./build.sh: OSTYPE: parameter not set` というエラーが出る)場合は `export OSTYPE; ./plarails.sh <APP_NAME>`
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
