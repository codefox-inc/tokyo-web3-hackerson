## 環境構築
```sh
docker compose build
docker compose up -d
```

### クライアント
コンテナ内で
```
cd /application/src/client
yarn install
yarn dev
```
[http;//localhost:3000](http;//localhost:3000)でサーバーが起動する

### サーバー
コンテナ内で
```
cd /application/src/server
nimble install -y
cp .env.example .env
ducere serve
```
[http;//localhost:8000](http;//localhost:8000)でサーバーが起動する
